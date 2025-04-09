import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/_data/enum/fnb_action_enum.dart';
import 'package:kualiva/_data/enum/paging_enum.dart';
import 'package:kualiva/_data/enum/recent_suggestion_enum.dart';
import 'package:kualiva/_data/model/pagination/pagination.dart';
import 'package:kualiva/_data/model/pagination/paging.dart';
import 'package:kualiva/_data/model/ui_model/filters_model.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/dataset/filter_dataset.dart';
import 'package:kualiva/common/feature/current_location/current_location_bloc.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/common/widget/custom_app_bar.dart';
import 'package:kualiva/places/fnb/argument/fnb_action_argument.dart';
import 'package:kualiva/places/fnb/bloc/fnb_action_bloc.dart';
import 'package:kualiva/places/fnb/bloc/fnb_nearest_bloc.dart';
import 'package:kualiva/places/fnb/bloc/fnb_promo_bloc.dart';
import 'package:kualiva/places/fnb/bloc/fnb_recommended_bloc.dart';
import 'package:kualiva/places/fnb/feature/fnb_action_feature.dart';
import 'package:kualiva/places/fnb/feature/fnb_action_search_bar_feature.dart';
import 'package:kualiva/places/fnb/widget/fnb_filters_item.dart';

class FnbActionScreen extends StatefulWidget {
  const FnbActionScreen({
    super.key,
    required this.fnbActionArgument,
  });

  final FnbActionArgument fnbActionArgument;

  @override
  State<FnbActionScreen> createState() => _FnbActionScreenState();
}

class _FnbActionScreenState extends State<FnbActionScreen> {
  FnbActionEnum get fnbActionEnum => widget.fnbActionArgument.fnbActionEnum;
  final _title = ValueNotifier<String>("");
  final _searchName = ValueNotifier<String?>(null);

  final _scrollController = ScrollController();
  final _paging = ValueNotifier(Paging());
  PagingEnum _pagingEnum = PagingEnum.before;

  final List<String> _listTagsFilter = FilterDataset.fnbFoodFilter;

  final selectedFilters = ValueNotifier<Set<String>>({});

  FiltersModel? filtersModel;

  void _onScrollPagination() {
    if (_scrollController.position.pixels !=
        _scrollController.position.maxScrollExtent) {
      return;
    }
    final state = context.read<FnbActionBloc>().state;

    if (state is FnbActionSuccessNearest) {
      final pagination = state.fnbNearestPage.pagination;
      _nextPaging(pagination);
      return;
    }
    if (state is FnbActionSuccessPromo) {
      final pagination = state.fnbPromoPage.pagination;
      _nextPaging(pagination);
      return;
    }
    if (state is FnbActionSuccessRecommended) {
      final pagination = state.fnbRecommendedPage.pagination;
      _nextPaging(pagination);
      return;
    }
  }

  void _nextPaging(Pagination pagination) {
    if (_paging.value.canNextPage(pagination)) return;
    _paging.value = Paging.fromPaginationNext(pagination);
    _pagingEnum = PagingEnum.paged;

    LeLog.sd(this, _nextPaging, 'Next Paging ${_paging.value}');
  }

  void initActionBLoC() {
    if (_searchName.value != null) {
      _pagingEnum = PagingEnum.refreshed;
      _paging.value = Paging();
      return;
    }
    if (fnbActionEnum == FnbActionEnum.nearest) {
      final state = context.read<FnbNearestBloc>().state;
      if (state is! FnbNearestSuccess) return;
      final pagination = state.fnbNearestPage.pagination;
      _paging.value = Paging.fromPaginationCurrent(pagination);
      return;
    }
    if (fnbActionEnum == FnbActionEnum.promo) {
      final state = context.read<FnbPromoBloc>().state;
      if (state is! FnbPromoSuccess) return;
      final pagination = state.fnbPromoPage.pagination;
      _paging.value = Paging.fromPaginationCurrent(pagination);
      return;
    }
    if (fnbActionEnum == FnbActionEnum.recommended) {
      final state = context.read<FnbRecommendedBloc>().state;
      if (state is! FnbRecommendedSuccess) return;
      final pagination = state.fnbRecommendedPage.pagination;
      _paging.value = Paging.fromPaginationCurrent(pagination);
      return;
    }
  }

  void _pagingListener() {
    final location = context.read<CurrentLocationBloc>().state;
    if (location is! CurrentLocationSuccess) return;
    context.read<FnbActionBloc>().add(FnbActionFetched(
          paging: _paging.value,
          pagingEnum: _pagingEnum,
          fnbActionEnum: fnbActionEnum,
          latitude: location.currentLocationModel.latitude,
          longitude: location.currentLocationModel.longitude,
          name: _searchName.value,
        ));
  }

  Future<void> _onRetry() async {
    _paging.value = await context.read<FnbActionBloc>().currentPaging();
    _pagingEnum = PagingEnum.refreshed;
  }

  void _onSearchBarSubmitted(BuildContext context, String value) {
    _title.value = value;
    _searchName.value = value;
    _pagingEnum = PagingEnum.refreshed;
    _paging.value = Paging();
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _title.value = widget.fnbActionArgument.title;
    _searchName.value = widget.fnbActionArgument.searchName;
    _paging.addListener(_pagingListener);
    _scrollController.addListener(_onScrollPagination);
    initActionBLoC();
  }

  @override
  void dispose() {
    super.dispose();
    _paging.removeListener(_pagingListener);
    _paging.dispose();
    _scrollController.removeListener(_onScrollPagination);
    _scrollController.dispose();

    _title.dispose();
    _searchName.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CurrentLocationBloc, CurrentLocationState>(
      listener: (context, location) {
        if (location is! CurrentLocationSuccess) return;

        final bool isRefresh = location.isDistanceTooFarOrFirstTime;

        final (paging, pagingEnum) = ((isRefresh == true)
            ? (Paging(), PagingEnum.refreshed)
            : (_paging.value, PagingEnum.before));

        _paging.value = paging;
        _pagingEnum = pagingEnum;
      },
      child: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: _title,
          child: _body(context),
          builder: (context, value, child) {
            return Scaffold(
              appBar: _fnbActionAppBar(context, value),
              body: child,
            );
          },
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: Sizeutils.height,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            SizedBox(height: 5.h),
            FnbActionSearchBarFeature(
              recentSuggestionEnum: RecentSuggestionEnum.fnb,
              isSliverSearchBar: false,
              viewOnSubmitted: _onSearchBarSubmitted,
            ),
            SizedBox(height: 5.h),
            _tagsFilter(context),
            SizedBox(height: 5.h),
            FnbActionFeature(
              onRetry: _onRetry,
            ),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _fnbActionAppBar(BuildContext context, String title) {
    return CustomAppBar(
      title: title,
      useLeading: true,
      onBackPressed: () => Navigator.pop(context),
    );
  }

  Widget _tagsFilter(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.h),
      child: SizedBox(
        height: 30.h,
        width: double.maxFinite,
        child: ListView.builder(
          itemCount: _listTagsFilter.length + 1,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            //TODO add waiting, empty, error state in future
            if (index == 0) return _filterScreenBtn(context, index, label: "");
            if ((index - 1) == 0) {
              return FnbFiltersItem(
                label: _listTagsFilter[index - 1],
                isWrap: false,
                multiSelect: true,
                isExecutive: true,
                multiSelectedChoices: selectedFilters,
              );
            }
            return FnbFiltersItem(
              label: _listTagsFilter[index - 1],
              isWrap: false,
              multiSelect: true,
              multiSelectedChoices: selectedFilters,
            );
          },
        ),
      ),
    );
  }

  Widget _filterScreenBtn(BuildContext context, int index, {String? label}) {
    return InkWell(
      borderRadius: BorderRadius.circular(50.h),
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.fnbFilterScreen,
                arguments: filtersModel)
            .then(
          (value) {
            if (value == null) return;
            setState(() {
              filtersModel = value as FiltersModel;
            });
          },
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.h),
        padding: EdgeInsets.symmetric(horizontal: 4.h),
        decoration: CustomDecoration(context).fillPrimary.copyWith(
              borderRadius: BorderRadius.circular(50.h),
            ),
        child: Center(
          child: Center(
            child: Icon(
              Icons.filter_alt,
              size: 20.h,
            ),
          ),
        ),
      ),
    );
  }
}

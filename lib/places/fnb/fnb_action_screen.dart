import 'package:easy_localization/easy_localization.dart';
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
import 'package:kualiva/common/feature/search_bar/search_bar_feature.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/common/widget/custom_app_bar.dart';
import 'package:kualiva/places/fnb/argument/fnb_action_argument.dart';
import 'package:kualiva/places/fnb/bloc/fnb_action_bloc.dart';
import 'package:kualiva/places/fnb/bloc/fnb_nearest_bloc.dart';
import 'package:kualiva/places/fnb/bloc/fnb_promo_bloc.dart';
import 'package:kualiva/places/fnb/bloc/fnb_recommended_bloc.dart';
import 'package:kualiva/places/fnb/feature/fnb_action_feature.dart';
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
  String get title => widget.fnbActionArgument.title;

  final _scrollController = ScrollController();
  final _paging = ValueNotifier(Paging());

  final List<String> _listTagsFilter = FilterDataset.fnbFoodFilter;

  final selectedFilters = ValueNotifier<Set<String>>({});

  FiltersModel? filtersModel;

  void _onScrollPagination() {
    print("_onScrollPagination");
    if (_scrollController.position.pixels !=
        _scrollController.position.maxScrollExtent) {
      return;
    }
    print('Max Scroll');
    final state = context.read<FnbActionBloc>().state;
    print(state.toString());
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
    print('Hesoyam 2');
    print(_paging.value.toString());
    print(pagination);
    if (_paging.value.canNextPage(pagination)) return;
    _paging.value = Paging.fromPaginationNext(pagination);
    print(_paging.value.toString());
    final location = context.read<CurrentLocationBloc>().state;
    if (location is! CurrentLocationSuccess) return;
    LeLog.sd(this, _nextPaging, 'Next Paging ${_paging.value}');

    context.read<FnbActionBloc>().add(FnbActionFetched(
          paging: _paging.value,
          pagingEnum: PagingEnum.paged,
          fnbActionEnum: fnbActionEnum,
          latitude: location.currentLocationModel.latitude,
          longitude: location.currentLocationModel.longitude,
        ));
  }

  void initActionBLoC() {
    final location = context.read<CurrentLocationBloc>().state;
    if (location is! CurrentLocationSuccess) return;
    context.read<FnbActionBloc>().add(FnbActionFetched(
          paging: Paging(),
          pagingEnum: PagingEnum.before,
          fnbActionEnum: fnbActionEnum,
          latitude: location.currentLocationModel.latitude,
          longitude: location.currentLocationModel.longitude,
        ));
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
      print("Hesoyam");
      print(pagination);
      print(_paging.value.toString());
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    initActionBLoC();
    _scrollController.addListener(_onScrollPagination);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_onScrollPagination);
    _scrollController.dispose();
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

        context.read<FnbActionBloc>().add(FnbActionFetched(
              paging: paging,
              pagingEnum: pagingEnum,
              fnbActionEnum: fnbActionEnum,
              latitude: location.currentLocationModel.latitude,
              longitude: location.currentLocationModel.longitude,
            ));
      },
      child: SafeArea(
        child: Scaffold(
          appBar: _fnbActionAppBar(context),
          body: _body(context),
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
            SearchBarFeature(
              recentSuggestionEnum: RecentSuggestionEnum.fnb,
              isSliverSearchBar: false,
            ),
            SizedBox(height: 5.h),
            _tagsFilter(context),
            SizedBox(height: 5.h),
            FnbActionFeature(
              scrollController: ScrollController(), // TODO: Hapus
            ),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _fnbActionAppBar(BuildContext context) {
    return CustomAppBar(
      title: context.tr(title),
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

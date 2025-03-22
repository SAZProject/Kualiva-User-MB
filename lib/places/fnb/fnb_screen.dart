import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/_data/enum/paging_enum.dart';
import 'package:kualiva/_data/enum/place_category_enum.dart';
import 'package:kualiva/_data/enum/recent_suggestion_enum.dart';
import 'package:kualiva/_data/model/pagination/pagination.dart';
import 'package:kualiva/_data/model/pagination/paging.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/dataset/filter_dataset.dart';
import 'package:kualiva/common/feature/current_location/current_location_bloc.dart';
import 'package:kualiva/_data/model/ui_model/filters_model.dart';
import 'package:kualiva/common/feature/search_bar/search_bar_feature.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/places/fnb/bloc/fnb_nearest_bloc.dart';
import 'package:kualiva/places/fnb/bloc/fnb_promo_bloc.dart';
import 'package:kualiva/places/fnb/feature/fnb_app_bar_feature.dart';
import 'package:kualiva/places/fnb/feature/fnb_nearest_feature.dart';
import 'package:kualiva/places/fnb/feature/fnb_promo_feature.dart';
import 'package:kualiva/places/fnb/widget/fnb_filters_item.dart';

class FnbScreen extends StatefulWidget {
  const FnbScreen({super.key});

  @override
  State<FnbScreen> createState() => _FnbScreenState();
}

class _FnbScreenState extends State<FnbScreen> {
  static const placeCategoryEnum = PlaceCategoryEnum.fnb;

  final _parentScrollController = ScrollController();
  final _childScrollController = ScrollController();
  final _paging = ValueNotifier(Paging());

  final List<String> _listTagsFilter = FilterDataset.fnbFoodFilter;

  final selectedFilters = ValueNotifier<Set<String>>({});

  FiltersModel? filtersModel;

  void _onScrollPagination() {
    if (_childScrollController.position.pixels !=
        _childScrollController.position.maxScrollExtent) {
      return;
    }
    final state = context.read<FnbNearestBloc>().state;
    if (state is! FnbNearestSuccess) return;
    final pagination = state.fnbNearestPage.pagination;
    _nextPaging(pagination);
  }

  void _nextPaging(Pagination pagination) {
    if (_paging.value.page == pagination.totalPage) return;
    _paging.value = Paging(
      page: pagination.nextPage ?? pagination.totalPage,
      size: pagination.size,
    );
    final state = context.read<CurrentLocationBloc>().state;
    if (state is! CurrentLocationSuccess) return;
    LeLog.sd(this, _nextPaging, 'Next Paging ${_paging.value}');
    context.read<FnbNearestBloc>().add(FnbNearestFetched(
          paging: _paging.value,
          pagingEnum: PagingEnum.paged,
          latitude: state.currentLocationModel.latitude,
          longitude: state.currentLocationModel.longitude,
        ));
  }

  @override
  void initState() {
    super.initState();
    _childScrollController.addListener(_onScrollPagination);
  }

  @override
  void dispose() {
    _childScrollController.removeListener(_onScrollPagination);
    _parentScrollController.dispose();
    _childScrollController.dispose();
    selectedFilters.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CurrentLocationBloc, CurrentLocationState>(
      listener: (context, state) {
        if (state is! CurrentLocationSuccess) return;

        final bool isRefresh = state.isDistanceTooFarOrFirstTime;

        context.read<FnbPromoBloc>().add(FnbPromoFetched(
              isRefreshed: state.isDistanceTooFarOrFirstTime,
              placeCategoryEnum: placeCategoryEnum,
            ));

        final (paging, pagingEnum) = ((isRefresh == true)
            ? (Paging(), PagingEnum.refreshed)
            : (_paging.value, PagingEnum.before));

        context.read<FnbNearestBloc>().add(FnbNearestFetched(
              paging: paging,
              pagingEnum: pagingEnum,
              latitude: state.currentLocationModel.latitude,
              longitude: state.currentLocationModel.longitude,
            ));
      },
      child: SafeArea(
        child: Scaffold(
          body: _body(context),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height,
      child: NestedScrollView(
        controller: _parentScrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            FnbAppBarFeature(),
            SearchBarFeature(recentSuggestionEnum: RecentSuggestionEnum.fnb),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 5.h),
              _tagsFilter(context),
              SizedBox(height: 5.h),
              FnbNearestFeature(
                parentScrollController: _parentScrollController,
                childScrollController: _childScrollController,
              ),
              SizedBox(height: 5.h),
              FnbPromoFeature(),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/_data/enum/fnb_action_enum.dart';
import 'package:kualiva/_data/enum/paging_enum.dart';
import 'package:kualiva/_data/enum/recent_suggestion_enum.dart';
import 'package:kualiva/_data/model/pagination/pagination.dart';
import 'package:kualiva/_data/model/pagination/paging.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/feature/current_location/current_location_bloc.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/places/fnb/bloc/fnb_action_bloc.dart';
import 'package:kualiva/places/fnb/bloc/fnb_nearest_bloc.dart';
import 'package:kualiva/places/fnb/bloc/fnb_promo_bloc.dart';
import 'package:kualiva/places/fnb/bloc/fnb_recommended_bloc.dart';
import 'package:kualiva/places/fnb/feature/fnb__main_search_bar_feature.dart';
import 'package:kualiva/places/fnb/feature/fnb_app_bar_feature.dart';
import 'package:kualiva/places/fnb/feature/fnb_nearest_feature.dart';
import 'package:kualiva/places/fnb/feature/fnb_promo_feature.dart';
import 'package:kualiva/places/fnb/feature/fnb_recommended_feature.dart';

class FnbScreen extends StatefulWidget {
  const FnbScreen({super.key});

  @override
  State<FnbScreen> createState() => _FnbScreenState();
}

class _FnbScreenState extends State<FnbScreen> {
  final _parentScrollController = ScrollController();

  final _promoScrollController = ScrollController();
  final _nearestScrollController = ScrollController();
  final _recommendedScrollController = ScrollController();

  final _pagingPromo = ValueNotifier(Paging());
  final _pagingNearest = ValueNotifier(Paging());
  final _pagingRecommended = ValueNotifier(Paging());

  /// Promo
  void _onPromoScrollPagination() {
    if (_promoScrollController.position.pixels !=
        _promoScrollController.position.maxScrollExtent) {
      return;
    }
    final state = context.read<FnbPromoBloc>().state;
    if (state is! FnbPromoSuccess) return;
    final pagination = state.fnbPromoPage.pagination;
    LeLog.sd(this, _onPromoScrollPagination, 'Trigger Max Scroll Controller');
    _nextPromoPaging(pagination);
  }

  void _nextPromoPaging(Pagination pagination) {
    if (_pagingPromo.value.canNextPage(pagination)) return;
    _pagingPromo.value = Paging.fromPaginationNext(pagination);
    final location = context.read<CurrentLocationBloc>().state;
    if (location is! CurrentLocationSuccess) return;
    LeLog.sd(this, _nextPromoPaging, 'Next Paging ${_pagingPromo.value}');
    context.read<FnbPromoBloc>().add(FnbPromoFetched(
          paging: _pagingPromo.value,
          pagingEnum: PagingEnum.paged,
          latitude: location.currentLocationModel.latitude,
          longitude: location.currentLocationModel.longitude,
        ));
  }

  /// Nearest
  void _onNearestScrollPagination() {
    if (_nearestScrollController.position.pixels !=
        _nearestScrollController.position.maxScrollExtent) {
      return;
    }
    final state = context.read<FnbNearestBloc>().state;
    if (state is! FnbNearestSuccess) return;
    final pagination = state.fnbNearestPage.pagination;
    LeLog.sd(this, _onNearestScrollPagination, 'Trigger Max Scroll Controller');
    _nextNearestPaging(pagination);
  }

  void _nextNearestPaging(Pagination pagination) {
    if (_pagingNearest.value.canNextPage(pagination)) return;
    _pagingNearest.value = Paging.fromPaginationNext(pagination);
    final location = context.read<CurrentLocationBloc>().state;
    if (location is! CurrentLocationSuccess) return;
    LeLog.sd(this, _nextNearestPaging, 'Next Paging ${_pagingNearest.value}');
    context.read<FnbNearestBloc>().add(FnbNearestFetched(
          paging: _pagingNearest.value,
          pagingEnum: PagingEnum.paged,
          latitude: location.currentLocationModel.latitude,
          longitude: location.currentLocationModel.longitude,
        ));
  }

  /// Recommended
  void _onRecommendedScrollPagination() {
    if (_recommendedScrollController.position.pixels !=
        _recommendedScrollController.position.maxScrollExtent) {
      return;
    }
    final state = context.read<FnbRecommendedBloc>().state;
    if (state is! FnbRecommendedSuccess) return;
    final pagination = state.fnbRecommendedPage.pagination;
    LeLog.sd(
        this, _onRecommendedScrollPagination, 'Trigger Max Scroll Controller');
    _nextRecommendedPaging(pagination);
  }

  void _nextRecommendedPaging(Pagination pagination) {
    if (_pagingRecommended.value.canNextPage(pagination)) return;
    _pagingRecommended.value = Paging.fromPaginationNext(pagination);
    final location = context.read<CurrentLocationBloc>().state;
    if (location is! CurrentLocationSuccess) return;
    LeLog.sd(this, _nextRecommendedPaging,
        'Next Paging ${_pagingRecommended.value}');
    context.read<FnbRecommendedBloc>().add(FnbRecommendedFetched(
          paging: _pagingRecommended.value,
          pagingEnum: PagingEnum.paged,
          latitude: location.currentLocationModel.latitude,
          longitude: location.currentLocationModel.longitude,
        ));
  }

  void _onActionCallback(FnbActionEnum fnbActionEnum) {
    final fnbActionBloc = context.read<FnbActionBloc>().state;
    if (fnbActionBloc is FnbActionSuccessPromo) {
      final pagination = fnbActionBloc.fnbPromoPage.pagination;
      _pagingPromo.value = Paging.fromPaginationCurrent(pagination);
    }
    if (fnbActionBloc is FnbActionSuccessNearest) {
      final pagination = fnbActionBloc.fnbNearestPage.pagination;
      _pagingNearest.value = Paging.fromPaginationCurrent(pagination);
    }
    if (fnbActionBloc is FnbActionSuccessRecommended) {
      final pagination = fnbActionBloc.fnbRecommendedPage.pagination;
      _pagingRecommended.value = Paging.fromPaginationCurrent(pagination);
    }
    final location = context.read<CurrentLocationBloc>().state;
    if (location is! CurrentLocationSuccess) return;
    switch (fnbActionEnum) {
      case FnbActionEnum.promo:
        context.read<FnbPromoBloc>().add(FnbPromoFetched(
              paging: _pagingPromo.value,
              pagingEnum: PagingEnum.before,
              latitude: location.currentLocationModel.latitude,
              longitude: location.currentLocationModel.longitude,
            ));
        break;
      case FnbActionEnum.nearest:
        context.read<FnbNearestBloc>().add(FnbNearestFetched(
              paging: _pagingNearest.value,
              pagingEnum: PagingEnum.before,
              latitude: location.currentLocationModel.latitude,
              longitude: location.currentLocationModel.longitude,
            ));
        break;
      case FnbActionEnum.recommended:
        context.read<FnbRecommendedBloc>().add(FnbRecommendedFetched(
              paging: _pagingRecommended.value,
              pagingEnum: PagingEnum.before,
              latitude: location.currentLocationModel.latitude,
              longitude: location.currentLocationModel.longitude,
            ));
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _promoScrollController.addListener(_onPromoScrollPagination);
    _nearestScrollController.addListener(_onNearestScrollPagination);
    _recommendedScrollController.addListener(_onRecommendedScrollPagination);
  }

  @override
  void dispose() {
    _promoScrollController.removeListener(_onPromoScrollPagination);
    _nearestScrollController.removeListener(_onNearestScrollPagination);
    _recommendedScrollController.removeListener(_onRecommendedScrollPagination);

    _parentScrollController.dispose();
    _promoScrollController.dispose();
    _nearestScrollController.dispose();
    _recommendedScrollController.dispose();
    super.dispose();
  }

  (Paging, Paging, Paging, PagingEnum) preparePaging(bool isRefresh) {
    if (isRefresh) {
      return (Paging(), Paging(), Paging(), PagingEnum.refreshed);
    }
    return (
      _pagingPromo.value,
      _pagingNearest.value,
      _pagingRecommended.value,
      PagingEnum.before
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CurrentLocationBloc, CurrentLocationState>(
      listener: (context, location) {
        if (location is! CurrentLocationSuccess) return;

        final bool isRefresh = location.isDistanceTooFarOrFirstTime;

        final (
          pagingPromo,
          pagingNearest,
          pagingRecommended,
          pagingEnum,
        ) = preparePaging(isRefresh);

        context.read<FnbPromoBloc>().add(FnbPromoFetched(
              paging: pagingPromo,
              pagingEnum: pagingEnum,
              latitude: location.currentLocationModel.latitude,
              longitude: location.currentLocationModel.longitude,
            ));

        context.read<FnbNearestBloc>().add(FnbNearestFetched(
              paging: pagingNearest,
              pagingEnum: pagingEnum,
              latitude: location.currentLocationModel.latitude,
              longitude: location.currentLocationModel.longitude,
            ));

        context.read<FnbRecommendedBloc>().add(FnbRecommendedFetched(
              paging: pagingRecommended,
              pagingEnum: pagingEnum,
              latitude: location.currentLocationModel.latitude,
              longitude: location.currentLocationModel.longitude,
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
            FnbMainSearchBarFeature(
                recentSuggestionEnum: RecentSuggestionEnum.fnb),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 5.h),
              FnbPromoFeature(
                childScrollController: _promoScrollController,
                onFnbActionCallback: _onActionCallback,
              ),
              SizedBox(height: 5.h),
              FnbNearestFeature(
                childScrollController: _nearestScrollController,
                onFnbActionCallback: _onActionCallback,
              ),
              SizedBox(height: 5.h),
              FnbRecommendedFeature(
                parentScrollController: _parentScrollController,
                childScrollController: _recommendedScrollController,
                onFnbActionCallback: _onActionCallback,
              ),
              SizedBox(height: 25.h),
            ],
          ),
        ),
      ),
    );
  }
}

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
import 'package:kualiva/places/fnb/feature/fnb_main_search_bar_feature.dart';
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

  PagingEnum _pagingEnumPromo = PagingEnum.before;
  PagingEnum _pagingEnumNearest = PagingEnum.before;
  PagingEnum _pagingEnumRecommended = PagingEnum.before;

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
    _pagingEnumPromo = PagingEnum.paged;
    _pagingPromo.value = Paging.fromPaginationNext(pagination);

    LeLog.sd(this, _nextPromoPaging, 'Next Paging ${_pagingPromo.value}');
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

    LeLog.sd(this, _nextNearestPaging, 'Next Paging ${_pagingNearest.value}');
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

    LeLog.sd(this, _nextRecommendedPaging,
        'Next Paging ${_pagingRecommended.value}');
  }

  void _onActionCallback(FnbActionEnum fnbActionEnum) {
    final fnbActionBloc = context.read<FnbActionBloc>().state;
    if (fnbActionBloc is FnbActionSuccessPromo) {
      final pagination = fnbActionBloc.fnbPromoPage.pagination;
      _pagingEnumPromo = PagingEnum.before;
      _pagingPromo.value = Paging.fromPaginationCurrent(pagination);
    }
    if (fnbActionBloc is FnbActionSuccessNearest) {
      final pagination = fnbActionBloc.fnbNearestPage.pagination;
      _pagingEnumNearest = PagingEnum.before;
      _pagingNearest.value = Paging.fromPaginationCurrent(pagination);
    }
    if (fnbActionBloc is FnbActionSuccessRecommended) {
      final pagination = fnbActionBloc.fnbRecommendedPage.pagination;
      _pagingEnumRecommended = PagingEnum.before;
      _pagingRecommended.value = Paging.fromPaginationCurrent(pagination);
    }
  }

  void _pagingPromoListener() {
    final location = context.read<CurrentLocationBloc>().state;
    if (location is! CurrentLocationSuccess) return;
    context.read<FnbPromoBloc>().add(FnbPromoFetched(
          paging: _pagingPromo.value,
          pagingEnum: _pagingEnumPromo,
          latitude: location.currentLocationModel.latitude,
          longitude: location.currentLocationModel.longitude,
        ));
  }

  void _pagingNearestListener() {
    final location = context.read<CurrentLocationBloc>().state;
    if (location is! CurrentLocationSuccess) return;
    context.read<FnbNearestBloc>().add(FnbNearestFetched(
          paging: _pagingNearest.value,
          pagingEnum: _pagingEnumNearest,
          latitude: location.currentLocationModel.latitude,
          longitude: location.currentLocationModel.longitude,
        ));
  }

  void _pagingRecommendedListener() {
    final location = context.read<CurrentLocationBloc>().state;
    if (location is! CurrentLocationSuccess) return;
    context.read<FnbRecommendedBloc>().add(FnbRecommendedFetched(
          paging: _pagingRecommended.value,
          pagingEnum: _pagingEnumRecommended,
          latitude: location.currentLocationModel.latitude,
          longitude: location.currentLocationModel.longitude,
        ));
  }

  @override
  void initState() {
    super.initState();
    _promoScrollController.addListener(_onPromoScrollPagination);
    _nearestScrollController.addListener(_onNearestScrollPagination);
    _recommendedScrollController.addListener(_onRecommendedScrollPagination);

    _pagingPromo.addListener(_pagingPromoListener);
    _pagingNearest.addListener(_pagingNearestListener);
    _pagingRecommended.addListener(_pagingRecommendedListener);
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

    _pagingPromo.removeListener(_pagingPromoListener);
    _pagingNearest.removeListener(_pagingNearestListener);
    _pagingRecommended.removeListener(_pagingRecommendedListener);

    _pagingPromo.dispose();
    _pagingNearest.dispose();
    _pagingRecommended.dispose();
    super.dispose();
  }

  (Paging, Paging, Paging, PagingEnum) preparePaging(bool isRefresh) {
    if (isRefresh) {
      return (Paging(), Paging(), Paging(), PagingEnum.refreshed);
    }
    return (
      Paging.fromPaging(_pagingPromo.value),
      Paging.fromPaging(_pagingNearest.value),
      Paging.fromPaging(_pagingRecommended.value),
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

        _pagingEnumPromo =
            _pagingEnumNearest = _pagingEnumRecommended = pagingEnum;

        _pagingPromo.value = pagingPromo;
        _pagingNearest.value = pagingNearest;
        _pagingRecommended.value = pagingRecommended;
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

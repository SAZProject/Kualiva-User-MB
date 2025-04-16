import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/_data/enum/nightlife_action_enum.dart';
import 'package:kualiva/_data/enum/paging_enum.dart';
import 'package:kualiva/_data/enum/recent_suggestion_enum.dart';
import 'package:kualiva/_data/model/pagination/pagination.dart';
import 'package:kualiva/_data/model/pagination/paging.dart';
import 'package:kualiva/common/feature/current_location/current_location_bloc.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/common/utility/sized_utils.dart';
import 'package:kualiva/places/nightlife/bloc/nightlife_action_bloc.dart';
import 'package:kualiva/places/nightlife/bloc/nightlife_nearest_bloc.dart';
import 'package:kualiva/places/nightlife/bloc/nightlife_promo_bloc.dart';
import 'package:kualiva/places/nightlife/bloc/nightlife_recommended_bloc.dart';
import 'package:kualiva/places/nightlife/feature/nightlife_app_bar_feature.dart';
import 'package:kualiva/places/nightlife/feature/nightlife_main_search_bar_feature.dart';
import 'package:kualiva/places/nightlife/feature/nightlife_nearest_feature.dart';
import 'package:kualiva/places/nightlife/feature/nightlife_promo_feature.dart';
import 'package:kualiva/places/nightlife/feature/nightlife_recommended_feature.dart';

class NightlifeScreen extends StatefulWidget {
  const NightlifeScreen({super.key});

  @override
  State<NightlifeScreen> createState() => _NightlifeScreenState();
}

class _NightlifeScreenState extends State<NightlifeScreen> {
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
    final state = context.read<NightlifePromoBloc>().state;
    if (state is! NightlifePromoSuccess) return;
    final pagination = state.nightlifePromoPage.pagination;
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
    final state = context.read<NightlifeNearestBloc>().state;
    if (state is! NightlifeNearestSuccess) return;
    final pagination = state.nightlifeNearestPage.pagination;
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
    final state = context.read<NightlifeRecommendedBloc>().state;
    if (state is! NightlifeRecommendedSuccess) return;
    final pagination = state.nightlifeRecommendedPage.pagination;
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

  void _onNightlifeActionCallback(NightlifeActionEnum nightlifeActionEnum) {
    final nightlifeActionBloc = context.read<NightlifeActionBloc>().state;
    if (nightlifeActionBloc is NightlifeActionSuccessPromo) {
      final pagination = nightlifeActionBloc.nightlifePromoPage.pagination;
      _pagingEnumPromo = PagingEnum.before;
      _pagingPromo.value = Paging.fromPaginationCurrent(pagination);
    }
    if (nightlifeActionBloc is NightlifeActionSuccessNearest) {
      final pagination = nightlifeActionBloc.nightlifeNearestPage.pagination;
      _pagingEnumNearest = PagingEnum.before;
      _pagingNearest.value = Paging.fromPaginationCurrent(pagination);
    }
    if (nightlifeActionBloc is NightlifeActionSuccessRecommended) {
      final pagination =
          nightlifeActionBloc.nightlifeRecommendedPage.pagination;
      _pagingEnumRecommended = PagingEnum.before;
      _pagingRecommended.value = Paging.fromPaginationCurrent(pagination);
    }
  }

  void _pagingPromoListener() {
    final location = context.read<CurrentLocationBloc>().state;
    if (location is! CurrentLocationSuccess) return;
    context.read<NightlifePromoBloc>().add(NightlifePromoFetched(
          paging: _pagingPromo.value,
          pagingEnum: _pagingEnumPromo,
          latitude: location.currentLocationModel.latitude,
          longitude: location.currentLocationModel.longitude,
        ));
  }

  void _pagingNearestListener() {
    final location = context.read<CurrentLocationBloc>().state;
    if (location is! CurrentLocationSuccess) return;
    context.read<NightlifeNearestBloc>().add(NightlifeNearestFetched(
          paging: _pagingNearest.value,
          pagingEnum: _pagingEnumNearest,
          latitude: location.currentLocationModel.latitude,
          longitude: location.currentLocationModel.longitude,
        ));
  }

  void _pagingRecommendedListener() {
    final location = context.read<CurrentLocationBloc>().state;
    if (location is! CurrentLocationSuccess) return;
    context.read<NightlifeRecommendedBloc>().add(NightlifeRecommendedFetched(
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
            NightlifeAppBarFeature(),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              NightlifeMainSearchBarFeature(
                recentSuggestionEnum: RecentSuggestionEnum.nightlife,
                isSliverSearchBar: false,
              ),
              SizedBox(height: 5.h),
              NightlifePromoFeature(
                childScrollController: _promoScrollController,
                onNightlifeActionCallback: _onNightlifeActionCallback,
              ),
              SizedBox(height: 5.h),
              NightlifeNearestFeature(
                childScrollController: _nearestScrollController,
                onNightlifeActionCallback: _onNightlifeActionCallback,
              ),
              SizedBox(height: 5.h),
              NightlifeRecommendedFeature(
                parentScrollController: _parentScrollController,
                childScrollController: _recommendedScrollController,
                onNightlifeActionCallback: _onNightlifeActionCallback,
              ),
              SizedBox(height: 25.h),
            ],
          ),
        ),
      ),
    );
  }
}

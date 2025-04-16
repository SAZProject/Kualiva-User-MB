import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/_data/enum/recent_suggestion_enum.dart';
import 'package:kualiva/_data/enum/spa_action_enum.dart';
import 'package:kualiva/_data/enum/paging_enum.dart';
import 'package:kualiva/_data/model/pagination/pagination.dart';
import 'package:kualiva/_data/model/pagination/paging.dart';
import 'package:kualiva/common/feature/current_location/current_location_bloc.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/common/utility/sized_utils.dart';
import 'package:kualiva/places/spa/bloc/spa_action_bloc.dart';
import 'package:kualiva/places/spa/bloc/spa_nearest_bloc.dart';
import 'package:kualiva/places/spa/bloc/spa_promo_bloc.dart';
import 'package:kualiva/places/spa/bloc/spa_recommended_bloc.dart';
import 'package:kualiva/places/spa/feature/spa_app_bar_feature.dart';
import 'package:kualiva/places/spa/feature/spa_main_search_bar_feature.dart';
import 'package:kualiva/places/spa/feature/spa_nearest_feature.dart';
import 'package:kualiva/places/spa/feature/spa_promo_feature.dart';
import 'package:kualiva/places/spa/feature/spa_recommended_feature.dart';

class SpaScreen extends StatefulWidget {
  const SpaScreen({super.key});

  @override
  State<SpaScreen> createState() => _SpaScreenState();
}

class _SpaScreenState extends State<SpaScreen> {
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
    final state = context.read<SpaPromoBloc>().state;
    if (state is! SpaPromoSuccess) return;
    final pagination = state.spaPromoPage.pagination;
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
    final state = context.read<SpaNearestBloc>().state;
    if (state is! SpaNearestSuccess) return;
    final pagination = state.spaNearestPage.pagination;
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
    final state = context.read<SpaRecommendedBloc>().state;
    if (state is! SpaRecommendedSuccess) return;
    final pagination = state.spaRecommendedPage.pagination;
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

  void _onSpaActionCallback(SpaActionEnum spaActionEnum) {
    final spaActionBloc = context.read<SpaActionBloc>().state;
    if (spaActionBloc is SpaActionSuccessPromo) {
      final pagination = spaActionBloc.spaPromoPage.pagination;
      _pagingEnumPromo = PagingEnum.before;
      _pagingPromo.value = Paging.fromPaginationCurrent(pagination);
    }
    if (spaActionBloc is SpaActionSuccessNearest) {
      final pagination = spaActionBloc.spaNearestPage.pagination;
      _pagingEnumNearest = PagingEnum.before;
      _pagingNearest.value = Paging.fromPaginationCurrent(pagination);
    }
    if (spaActionBloc is SpaActionSuccessRecommended) {
      final pagination = spaActionBloc.spaRecommendedPage.pagination;
      _pagingEnumRecommended = PagingEnum.before;
      _pagingRecommended.value = Paging.fromPaginationCurrent(pagination);
    }
  }

  void _pagingPromoListener() {
    final location = context.read<CurrentLocationBloc>().state;
    if (location is! CurrentLocationSuccess) return;
    context.read<SpaPromoBloc>().add(SpaPromoFetched(
          paging: _pagingPromo.value,
          pagingEnum: _pagingEnumPromo,
          latitude: location.currentLocationModel.latitude,
          longitude: location.currentLocationModel.longitude,
        ));
  }

  void _pagingNearestListener() {
    final location = context.read<CurrentLocationBloc>().state;
    if (location is! CurrentLocationSuccess) return;
    context.read<SpaNearestBloc>().add(SpaNearestFetched(
          paging: _pagingNearest.value,
          pagingEnum: _pagingEnumNearest,
          latitude: location.currentLocationModel.latitude,
          longitude: location.currentLocationModel.longitude,
        ));
  }

  void _pagingRecommendedListener() {
    final location = context.read<CurrentLocationBloc>().state;
    if (location is! CurrentLocationSuccess) return;
    context.read<SpaRecommendedBloc>().add(SpaRecommendedFetched(
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
            SpaAppBarFeature(),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              SpaMainSearchBarFeature(
                recentSuggestionEnum: RecentSuggestionEnum.spa,
                isSliverSearchBar: false,
              ),
              SizedBox(height: 5.h),
              SpaPromoFeature(
                childScrollController: _promoScrollController,
                onSpaActionCallback: _onSpaActionCallback,
              ),
              SizedBox(height: 5.h),
              SpaNearestFeature(
                childScrollController: _nearestScrollController,
                onSpaActionCallback: _onSpaActionCallback,
              ),
              SizedBox(height: 5.h),
              SpaRecommendedFeature(
                parentScrollController: _parentScrollController,
                childScrollController: _recommendedScrollController,
                onSpaActionCallback: _onSpaActionCallback,
              ),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }
}

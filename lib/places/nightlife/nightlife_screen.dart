import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/_data/enum/nightlife_action_enum.dart';
import 'package:kualiva/_data/enum/paging_enum.dart';
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
    if (_pagingPromo.value.page == pagination.totalPage) return;
    _pagingPromo.value = Paging.fromPagination(pagination);
    final state = context.read<CurrentLocationBloc>().state;
    if (state is! CurrentLocationSuccess) return;
    LeLog.sd(this, _nextPromoPaging, 'Next Paging ${_pagingPromo.value}');
    context.read<NightlifePromoBloc>().add(NightlifePromoFetched(
          paging: _pagingPromo.value,
          pagingEnum: PagingEnum.paged,
          latitude: state.currentLocationModel.latitude,
          longitude: state.currentLocationModel.longitude,
        ));
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
    if (_pagingNearest.value.page == pagination.totalPage) return;
    _pagingNearest.value = Paging.fromPagination(pagination);
    final state = context.read<CurrentLocationBloc>().state;
    if (state is! CurrentLocationSuccess) return;
    LeLog.sd(this, _nextNearestPaging, 'Next Paging ${_pagingNearest.value}');
    context.read<NightlifeNearestBloc>().add(NightlifeNearestFetched(
          paging: _pagingNearest.value,
          pagingEnum: PagingEnum.paged,
          latitude: state.currentLocationModel.latitude,
          longitude: state.currentLocationModel.longitude,
        ));
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
    if (_pagingRecommended.value.page == pagination.totalPage) return;
    _pagingRecommended.value = Paging.fromPagination(pagination);
    final state = context.read<CurrentLocationBloc>().state;
    if (state is! CurrentLocationSuccess) return;
    LeLog.sd(this, _nextRecommendedPaging,
        'Next Paging ${_pagingRecommended.value}');
    context.read<NightlifeRecommendedBloc>().add(NightlifeRecommendedFetched(
          paging: _pagingRecommended.value,
          pagingEnum: PagingEnum.paged,
          latitude: state.currentLocationModel.latitude,
          longitude: state.currentLocationModel.longitude,
        ));
  }

  void _onNightlifeActionCallback(NightlifeActionEnum nightlifeActionEnum) {
    final nightlifeActionBloc = context.read<NightlifeActionBloc>().state;
    if (nightlifeActionBloc is NightlifeActionSuccessPromo) {
      final pagination = nightlifeActionBloc.nightlifePromoPage.pagination;
      _pagingPromo.value = Paging(
        page: pagination.nextPage ?? pagination.totalPage,
        size: pagination.size,
      );
    }
    if (nightlifeActionBloc is NightlifeActionSuccessNearest) {
      final pagination = nightlifeActionBloc.nightlifeNearestPage.pagination;
      _pagingNearest.value = Paging(
        page: pagination.nextPage ?? pagination.totalPage,
        size: pagination.size,
      );
    }
    if (nightlifeActionBloc is NightlifeActionSuccessRecommended) {
      final pagination =
          nightlifeActionBloc.nightlifeRecommendedPage.pagination;
      _pagingRecommended.value = Paging(
        page: pagination.nextPage ?? pagination.totalPage,
        size: pagination.size,
      );
    }
    final state = context.read<CurrentLocationBloc>().state;
    if (state is! CurrentLocationSuccess) return;
    switch (nightlifeActionEnum) {
      case NightlifeActionEnum.promo:
        context.read<NightlifePromoBloc>().add(NightlifePromoFetched(
              paging: _pagingPromo.value,
              pagingEnum: PagingEnum.before,
              latitude: state.currentLocationModel.latitude,
              longitude: state.currentLocationModel.longitude,
            ));
        break;
      case NightlifeActionEnum.nearest:
        context.read<NightlifeNearestBloc>().add(NightlifeNearestFetched(
              paging: _pagingNearest.value,
              pagingEnum: PagingEnum.before,
              latitude: state.currentLocationModel.latitude,
              longitude: state.currentLocationModel.longitude,
            ));
        break;
      case NightlifeActionEnum.recommended:
        context
            .read<NightlifeRecommendedBloc>()
            .add(NightlifeRecommendedFetched(
              paging: _pagingRecommended.value,
              pagingEnum: PagingEnum.before,
              latitude: state.currentLocationModel.latitude,
              longitude: state.currentLocationModel.longitude,
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
      listener: (context, state) {
        if (state is! CurrentLocationSuccess) return;

        final bool isRefresh = state.isDistanceTooFarOrFirstTime;

        final (
          pagingPromo,
          pagingNearest,
          pagingRecommended,
          pagingEnum,
        ) = preparePaging(isRefresh);

        context.read<NightlifePromoBloc>().add(NightlifePromoFetched(
              paging: pagingPromo,
              pagingEnum: pagingEnum,
              latitude: state.currentLocationModel.latitude,
              longitude: state.currentLocationModel.longitude,
            ));

        context.read<NightlifeNearestBloc>().add(NightlifeNearestFetched(
              paging: pagingNearest,
              pagingEnum: pagingEnum,
              latitude: state.currentLocationModel.latitude,
              longitude: state.currentLocationModel.longitude,
            ));

        context
            .read<NightlifeRecommendedBloc>()
            .add(NightlifeRecommendedFetched(
              paging: pagingRecommended,
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
            NightlifeAppBarFeature(),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
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
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }
}

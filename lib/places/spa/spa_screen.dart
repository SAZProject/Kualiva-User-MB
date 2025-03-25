import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    if (_pagingPromo.value.page == pagination.totalPage) return;
    _pagingPromo.value = Paging.fromPaginationNext(pagination);
    final state = context.read<CurrentLocationBloc>().state;
    if (state is! CurrentLocationSuccess) return;
    LeLog.sd(this, _nextPromoPaging, 'Next Paging ${_pagingPromo.value}');
    context.read<SpaPromoBloc>().add(SpaPromoFetched(
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
    final state = context.read<SpaNearestBloc>().state;
    if (state is! SpaNearestSuccess) return;
    final pagination = state.spaNearestPage.pagination;
    LeLog.sd(this, _onNearestScrollPagination, 'Trigger Max Scroll Controller');
    _nextNearestPaging(pagination);
  }

  void _nextNearestPaging(Pagination pagination) {
    if (_pagingNearest.value.page == pagination.totalPage) return;
    _pagingNearest.value = Paging.fromPaginationNext(pagination);
    final state = context.read<CurrentLocationBloc>().state;
    if (state is! CurrentLocationSuccess) return;
    LeLog.sd(this, _nextNearestPaging, 'Next Paging ${_pagingNearest.value}');
    context.read<SpaNearestBloc>().add(SpaNearestFetched(
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
    final state = context.read<SpaRecommendedBloc>().state;
    if (state is! SpaRecommendedSuccess) return;
    final pagination = state.spaRecommendedPage.pagination;
    LeLog.sd(
        this, _onRecommendedScrollPagination, 'Trigger Max Scroll Controller');
    _nextRecommendedPaging(pagination);
  }

  void _nextRecommendedPaging(Pagination pagination) {
    if (_pagingRecommended.value.page == pagination.totalPage) return;
    _pagingRecommended.value = Paging.fromPaginationNext(pagination);
    final state = context.read<CurrentLocationBloc>().state;
    if (state is! CurrentLocationSuccess) return;
    LeLog.sd(this, _nextRecommendedPaging,
        'Next Paging ${_pagingRecommended.value}');
    context.read<SpaRecommendedBloc>().add(SpaRecommendedFetched(
          paging: _pagingRecommended.value,
          pagingEnum: PagingEnum.paged,
          latitude: state.currentLocationModel.latitude,
          longitude: state.currentLocationModel.longitude,
        ));
  }

  void _onSpaActionCallback(SpaActionEnum spaActionEnum) {
    final spaActionBloc = context.read<SpaActionBloc>().state;
    if (spaActionBloc is SpaActionSuccessPromo) {
      final pagination = spaActionBloc.spaPromoPage.pagination;
      _pagingPromo.value = Paging(
        page: pagination.nextPage ?? pagination.totalPage,
        size: pagination.size,
      );
    }
    if (spaActionBloc is SpaActionSuccessNearest) {
      final pagination = spaActionBloc.spaNearestPage.pagination;
      _pagingNearest.value = Paging(
        page: pagination.nextPage ?? pagination.totalPage,
        size: pagination.size,
      );
    }
    if (spaActionBloc is SpaActionSuccessRecommended) {
      final pagination = spaActionBloc.spaRecommendedPage.pagination;
      _pagingRecommended.value = Paging(
        page: pagination.nextPage ?? pagination.totalPage,
        size: pagination.size,
      );
    }
    final state = context.read<CurrentLocationBloc>().state;
    if (state is! CurrentLocationSuccess) return;
    switch (spaActionEnum) {
      case SpaActionEnum.promo:
        context.read<SpaPromoBloc>().add(SpaPromoFetched(
              paging: _pagingPromo.value,
              pagingEnum: PagingEnum.before,
              latitude: state.currentLocationModel.latitude,
              longitude: state.currentLocationModel.longitude,
            ));
        break;
      case SpaActionEnum.nearest:
        context.read<SpaNearestBloc>().add(SpaNearestFetched(
              paging: _pagingNearest.value,
              pagingEnum: PagingEnum.before,
              latitude: state.currentLocationModel.latitude,
              longitude: state.currentLocationModel.longitude,
            ));
        break;
      case SpaActionEnum.recommended:
        context.read<SpaRecommendedBloc>().add(SpaRecommendedFetched(
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

        context.read<SpaPromoBloc>().add(SpaPromoFetched(
              paging: pagingPromo,
              pagingEnum: pagingEnum,
              latitude: state.currentLocationModel.latitude,
              longitude: state.currentLocationModel.longitude,
            ));

        context.read<SpaNearestBloc>().add(SpaNearestFetched(
              paging: pagingNearest,
              pagingEnum: pagingEnum,
              latitude: state.currentLocationModel.latitude,
              longitude: state.currentLocationModel.longitude,
            ));

        context.read<SpaRecommendedBloc>().add(SpaRecommendedFetched(
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
            SpaAppBarFeature(),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
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

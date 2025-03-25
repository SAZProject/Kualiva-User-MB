import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/_data/enum/nightlife_action_enum.dart';
import 'package:kualiva/_data/enum/paging_enum.dart';
import 'package:kualiva/_data/enum/recent_suggestion_enum.dart';
import 'package:kualiva/_data/model/pagination/pagination.dart';
import 'package:kualiva/_data/model/pagination/paging.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/feature/current_location/current_location_bloc.dart';
import 'package:kualiva/common/feature/search_bar/search_bar_feature.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/common/widget/custom_app_bar.dart';
import 'package:kualiva/places/nightlife/argument/nightlife_action_argument.dart';
import 'package:kualiva/places/nightlife/bloc/nightlife_action_bloc.dart';
import 'package:kualiva/places/nightlife/bloc/nightlife_nearest_bloc.dart';
import 'package:kualiva/places/nightlife/bloc/nightlife_promo_bloc.dart';
import 'package:kualiva/places/nightlife/bloc/nightlife_recommended_bloc.dart';
import 'package:kualiva/places/nightlife/feature/nightlife_action_feature.dart';

class NightlifeActionScreen extends StatefulWidget {
  const NightlifeActionScreen({
    super.key,
    required this.nightlifeActionArgument,
  });

  final NightlifeActionArgument nightlifeActionArgument;

  @override
  State<NightlifeActionScreen> createState() => _NightlifeActionScreenState();
}

class _NightlifeActionScreenState extends State<NightlifeActionScreen> {
  NightlifeActionEnum get nightlifeActionEnum =>
      widget.nightlifeActionArgument.nightlifeActionEnum;
  String get title => widget.nightlifeActionArgument.title;

  final _scrollController = ScrollController();
  final _paging = ValueNotifier(Paging());

  void _onScrollPagination() {
    if (_scrollController.position.pixels !=
        _scrollController.position.maxScrollExtent) {
      return;
    }
    final state = context.read<NightlifeActionBloc>().state;
    if (state is NightlifeActionSuccessNearest) {
      final pagination = state.nightlifeNearestPage.pagination;
      _nextPaging(pagination);
      return;
    }
    if (state is NightlifeActionSuccessPromo) {
      final pagination = state.nightlifePromoPage.pagination;
      _nextPaging(pagination);
      return;
    }
    if (state is NightlifeActionSuccessRecommended) {
      final pagination = state.nightlifeRecommendedPage.pagination;
      _nextPaging(pagination);
      return;
    }
  }

  void _nextPaging(Pagination pagination) {
    if (_paging.value.page == pagination.totalPage) return;
    _paging.value = Paging.fromPagination(pagination);
    final state = context.read<CurrentLocationBloc>().state;
    if (state is! CurrentLocationSuccess) return;
    LeLog.sd(this, _nextPaging, 'Next Paging ${_paging.value}');

    context.read<NightlifeActionBloc>().add(NightlifeActionFetched(
          paging: _paging.value,
          pagingEnum: PagingEnum.paged,
          nightlifeActionEnum: nightlifeActionEnum,
          latitude: state.currentLocationModel.latitude,
          longitude: state.currentLocationModel.longitude,
        ));
  }

  void initActionBLoC() {
    final state = context.read<CurrentLocationBloc>().state;
    if (state is! CurrentLocationSuccess) return;
    context.read<NightlifeActionBloc>().add(NightlifeActionFetched(
          paging: Paging(),
          pagingEnum: PagingEnum.before,
          nightlifeActionEnum: nightlifeActionEnum,
          latitude: state.currentLocationModel.latitude,
          longitude: state.currentLocationModel.longitude,
        ));
    if (nightlifeActionEnum == NightlifeActionEnum.nearest) {
      final state = context.read<NightlifeNearestBloc>().state;
      if (state is! NightlifeNearestSuccess) return;
      final pagination = state.nightlifeNearestPage.pagination;
      _paging.value = Paging.fromPagination(pagination);
      return;
    }
    if (nightlifeActionEnum == NightlifeActionEnum.promo) {
      final state = context.read<NightlifePromoBloc>().state;
      if (state is! NightlifePromoSuccess) return;
      final pagination = state.nightlifePromoPage.pagination;
      _paging.value = Paging.fromPagination(pagination);
      return;
    }
    if (nightlifeActionEnum == NightlifeActionEnum.recommended) {
      final state = context.read<NightlifeRecommendedBloc>().state;
      if (state is! NightlifeRecommendedSuccess) return;
      final pagination = state.nightlifeRecommendedPage.pagination;
      _paging.value = Paging.fromPagination(pagination);
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
      listener: (context, state) {
        if (state is! CurrentLocationSuccess) return;

        final bool isRefresh = state.isDistanceTooFarOrFirstTime;

        final (paging, pagingEnum) = ((isRefresh == true)
            ? (Paging(), PagingEnum.refreshed)
            : (_paging.value, PagingEnum.before));

        context.read<NightlifeActionBloc>().add(NightlifeActionFetched(
              paging: paging,
              pagingEnum: pagingEnum,
              nightlifeActionEnum: nightlifeActionEnum,
              latitude: state.currentLocationModel.latitude,
              longitude: state.currentLocationModel.longitude,
            ));
      },
      child: SafeArea(
        child: Scaffold(
          appBar: _nightlifeActionAppBar(context),
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
        child: Column(
          children: [
            SizedBox(height: 5.h),
            SearchBarFeature(
              recentSuggestionEnum: RecentSuggestionEnum.nightlife,
              isSliverSearchBar: false,
            ),
            SizedBox(height: 5.h),
            NightlifeActionFeature(
              scrollController: _scrollController,
            ),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _nightlifeActionAppBar(BuildContext context) {
    return CustomAppBar(
      title: context.tr(title),
      useLeading: true,
      onBackPressed: () => Navigator.pop(context),
    );
  }
}

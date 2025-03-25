import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/_data/enum/spa_action_enum.dart';
import 'package:kualiva/_data/enum/paging_enum.dart';
import 'package:kualiva/_data/enum/recent_suggestion_enum.dart';
import 'package:kualiva/_data/model/pagination/pagination.dart';
import 'package:kualiva/_data/model/pagination/paging.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/feature/current_location/current_location_bloc.dart';
import 'package:kualiva/common/feature/search_bar/search_bar_feature.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/common/widget/custom_app_bar.dart';
import 'package:kualiva/places/spa/argument/spa_action_argument.dart';
import 'package:kualiva/places/spa/bloc/spa_action_bloc.dart';
import 'package:kualiva/places/spa/bloc/spa_nearest_bloc.dart';
import 'package:kualiva/places/spa/bloc/spa_promo_bloc.dart';
import 'package:kualiva/places/spa/bloc/spa_recommended_bloc.dart';
import 'package:kualiva/places/spa/feature/spa_action_feature.dart';

class SpaActionScreen extends StatefulWidget {
  const SpaActionScreen({
    super.key,
    required this.spaActionArgument,
  });

  final SpaActionArgument spaActionArgument;

  @override
  State<SpaActionScreen> createState() => _SpaActionScreenState();
}

class _SpaActionScreenState extends State<SpaActionScreen> {
  SpaActionEnum get spaActionEnum => widget.spaActionArgument.spaActionEnum;
  String get title => widget.spaActionArgument.title;

  final _scrollController = ScrollController();
  final _paging = ValueNotifier(Paging());

  void _onScrollPagination() {
    if (_scrollController.position.pixels !=
        _scrollController.position.maxScrollExtent) {
      return;
    }
    final state = context.read<SpaActionBloc>().state;
    if (state is SpaActionSuccessNearest) {
      final pagination = state.spaNearestPage.pagination;
      _nextPaging(pagination);
      return;
    }
    if (state is SpaActionSuccessPromo) {
      final pagination = state.spaPromoPage.pagination;
      _nextPaging(pagination);
      return;
    }
    if (state is SpaActionSuccessRecommended) {
      final pagination = state.spaRecommendedPage.pagination;
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

    context.read<SpaActionBloc>().add(SpaActionFetched(
          paging: _paging.value,
          pagingEnum: PagingEnum.paged,
          spaActionEnum: spaActionEnum,
          latitude: state.currentLocationModel.latitude,
          longitude: state.currentLocationModel.longitude,
        ));
  }

  void initActionBLoC() {
    final state = context.read<CurrentLocationBloc>().state;
    if (state is! CurrentLocationSuccess) return;
    context.read<SpaActionBloc>().add(SpaActionFetched(
          paging: Paging(),
          pagingEnum: PagingEnum.before,
          spaActionEnum: spaActionEnum,
          latitude: state.currentLocationModel.latitude,
          longitude: state.currentLocationModel.longitude,
        ));

    if (spaActionEnum == SpaActionEnum.nearest) {
      final state = context.read<SpaNearestBloc>().state;
      if (state is! SpaNearestSuccess) return;
      final pagination = state.spaNearestPage.pagination;
      _paging.value = Paging.fromPagination(pagination);
      return;
    }
    if (spaActionEnum == SpaActionEnum.promo) {
      final state = context.read<SpaPromoBloc>().state;
      if (state is! SpaPromoSuccess) return;
      final pagination = state.spaPromoPage.pagination;
      _paging.value = Paging.fromPagination(pagination);
      return;
    }
    if (spaActionEnum == SpaActionEnum.recommended) {
      final state = context.read<SpaRecommendedBloc>().state;
      if (state is! SpaRecommendedSuccess) return;
      final pagination = state.spaRecommendedPage.pagination;
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

        context.read<SpaActionBloc>().add(SpaActionFetched(
              paging: paging,
              pagingEnum: pagingEnum,
              spaActionEnum: spaActionEnum,
              latitude: state.currentLocationModel.latitude,
              longitude: state.currentLocationModel.longitude,
            ));
      },
      child: SafeArea(
        child: Scaffold(
          appBar: _spaActionAppBar(context),
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
              recentSuggestionEnum: RecentSuggestionEnum.spa,
              isSliverSearchBar: false,
            ),
            SizedBox(height: 5.h),
            SpaActionFeature(
              scrollController: ScrollController(), // TODO: Hapus
            ),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _spaActionAppBar(BuildContext context) {
    return CustomAppBar(
      title: context.tr(title),
      useLeading: true,
      onBackPressed: () => Navigator.pop(context),
    );
  }
}

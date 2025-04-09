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
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/common/widget/custom_app_bar.dart';
import 'package:kualiva/places/spa/argument/spa_action_argument.dart';
import 'package:kualiva/places/spa/bloc/spa_action_bloc.dart';
import 'package:kualiva/places/spa/bloc/spa_nearest_bloc.dart';
import 'package:kualiva/places/spa/bloc/spa_promo_bloc.dart';
import 'package:kualiva/places/spa/bloc/spa_recommended_bloc.dart';
import 'package:kualiva/places/spa/feature/spa_action_feature.dart';
import 'package:kualiva/places/spa/feature/spa_action_search_bar_feature.dart';

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
  final _title = ValueNotifier<String>("");
  final _searchName = ValueNotifier<String?>(null);

  final _scrollController = ScrollController();
  final _paging = ValueNotifier(Paging());
  PagingEnum _pagingEnum = PagingEnum.before;

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
    if (_paging.value.canNextPage(pagination)) return;
    _paging.value = Paging.fromPaginationNext(pagination);
    _pagingEnum = PagingEnum.paged;

    LeLog.sd(this, _nextPaging, 'Next Paging ${_paging.value}');
  }

  void initActionBLoC() {
    if (_searchName.value != null) {
      _pagingEnum = PagingEnum.refreshed;
      _paging.value = Paging();
      return;
    }
    if (spaActionEnum == SpaActionEnum.nearest) {
      final state = context.read<SpaNearestBloc>().state;
      if (state is! SpaNearestSuccess) return;
      final pagination = state.spaNearestPage.pagination;
      _paging.value = Paging.fromPaginationCurrent(pagination);
      return;
    }
    if (spaActionEnum == SpaActionEnum.promo) {
      final state = context.read<SpaPromoBloc>().state;
      if (state is! SpaPromoSuccess) return;
      final pagination = state.spaPromoPage.pagination;
      _paging.value = Paging.fromPaginationCurrent(pagination);
      return;
    }
    if (spaActionEnum == SpaActionEnum.recommended) {
      final state = context.read<SpaRecommendedBloc>().state;
      if (state is! SpaRecommendedSuccess) return;
      final pagination = state.spaRecommendedPage.pagination;
      _paging.value = Paging.fromPaginationCurrent(pagination);
      return;
    }
  }

  void _pagingListener() {
    final location = context.read<CurrentLocationBloc>().state;
    if (location is! CurrentLocationSuccess) return;
    context.read<SpaActionBloc>().add(SpaActionFetched(
          paging: _paging.value,
          pagingEnum: _pagingEnum,
          spaActionEnum: spaActionEnum,
          latitude: location.currentLocationModel.latitude,
          longitude: location.currentLocationModel.longitude,
          name: _searchName.value,
        ));
  }

  Future<void> _onRetry() async {
    _paging.value = await context.read<SpaActionBloc>().currentPaging();
    _pagingEnum = PagingEnum.refreshed;
  }

  void _onSearchBarSubmitted(BuildContext context, String value) {
    _title.value = value;
    _searchName.value = value;
    _pagingEnum = PagingEnum.refreshed;
    _paging.value = Paging();
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _title.value = widget.spaActionArgument.title;
    _searchName.value = widget.spaActionArgument.searchName;
    _paging.addListener(_pagingListener);
    _scrollController.addListener(_onScrollPagination);
    initActionBLoC();
  }

  @override
  void dispose() {
    super.dispose();
    _paging.removeListener(_pagingListener);
    _paging.dispose();
    _scrollController.removeListener(_onScrollPagination);
    _scrollController.dispose();

    _title.dispose();
    _searchName.dispose();
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

        _paging.value = paging;
        _pagingEnum = pagingEnum;
      },
      child: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: _title,
          child: _body(context),
          builder: (context, value, child) {
            return Scaffold(
              appBar: _spaActionAppBar(context, value),
              body: child,
            );
          },
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
            SpaActionSearchBarFeature(
              recentSuggestionEnum: RecentSuggestionEnum.spa,
              isSliverSearchBar: false,
              viewOnSubmitted: _onSearchBarSubmitted,
            ),
            SizedBox(height: 5.h),
            SpaActionFeature(
              onRetry: _onRetry,
            ),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _spaActionAppBar(BuildContext context, String title) {
    return CustomAppBar(
      title: context.tr(title),
      useLeading: true,
      onBackPressed: () => Navigator.pop(context),
    );
  }
}

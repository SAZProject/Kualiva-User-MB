import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/_data/enum/nightlife_action_enum.dart';
import 'package:kualiva/_data/enum/paging_enum.dart';
import 'package:kualiva/_data/enum/recent_suggestion_enum.dart';
import 'package:kualiva/_data/model/pagination/pagination.dart';
import 'package:kualiva/_data/model/pagination/paging.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/feature/current_location/current_location_bloc.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/common/widget/custom_app_bar.dart';
import 'package:kualiva/places/nightlife/argument/nightlife_action_argument.dart';
import 'package:kualiva/places/nightlife/bloc/nightlife_action_bloc.dart';
import 'package:kualiva/places/nightlife/bloc/nightlife_nearest_bloc.dart';
import 'package:kualiva/places/nightlife/bloc/nightlife_promo_bloc.dart';
import 'package:kualiva/places/nightlife/bloc/nightlife_recommended_bloc.dart';
import 'package:kualiva/places/nightlife/feature/nightlife_action_feature.dart';
import 'package:kualiva/places/nightlife/feature/nightlife_action_search_bar_feature.dart';

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
    if (nightlifeActionEnum == NightlifeActionEnum.nearest) {
      final state = context.read<NightlifeNearestBloc>().state;
      if (state is! NightlifeNearestSuccess) return;
      final pagination = state.nightlifeNearestPage.pagination;
      _paging.value = Paging.fromPaginationCurrent(pagination);
      return;
    }
    if (nightlifeActionEnum == NightlifeActionEnum.promo) {
      final state = context.read<NightlifePromoBloc>().state;
      if (state is! NightlifePromoSuccess) return;
      final pagination = state.nightlifePromoPage.pagination;
      _paging.value = Paging.fromPaginationCurrent(pagination);
      return;
    }
    if (nightlifeActionEnum == NightlifeActionEnum.recommended) {
      final state = context.read<NightlifeRecommendedBloc>().state;
      if (state is! NightlifeRecommendedSuccess) return;
      final pagination = state.nightlifeRecommendedPage.pagination;
      _paging.value = Paging.fromPaginationCurrent(pagination);
      return;
    }
  }

  void _pagingListener() {
    final location = context.read<CurrentLocationBloc>().state;
    if (location is! CurrentLocationSuccess) return;
    context.read<NightlifeActionBloc>().add(NightlifeActionFetched(
          paging: _paging.value,
          pagingEnum: _pagingEnum,
          nightlifeActionEnum: nightlifeActionEnum,
          latitude: location.currentLocationModel.latitude,
          longitude: location.currentLocationModel.longitude,
          name: _searchName.value,
        ));
  }

  Future<void> _onRetry() async {
    _paging.value = await context.read<NightlifeActionBloc>().currentPaging();
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
    _title.value = widget.nightlifeActionArgument.title;
    _searchName.value = widget.nightlifeActionArgument.searchName;
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
          builder: (context, value, child) {
            return Scaffold(
              appBar: _nightlifeActionAppBar(context, value),
              body: child,
            );
          },
          child: _body(context),
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
            NightlifeActionSearchBarFeature(
              recentSuggestionEnum: RecentSuggestionEnum.nightlife,
              isSliverSearchBar: false,
              viewOnSubmitted: _onSearchBarSubmitted,
            ),
            SizedBox(height: 5.h),
            NightlifeActionFeature(
              onRetry: _onRetry,
            ),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _nightlifeActionAppBar(
      BuildContext context, String title) {
    return CustomAppBar(
      title: title,
      useLeading: true,
      onBackPressed: () => Navigator.pop(context),
    );
  }
}

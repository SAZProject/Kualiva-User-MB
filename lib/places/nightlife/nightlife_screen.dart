import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/_data/enum/paging_enum.dart';
import 'package:kualiva/_data/enum/place_category_enum.dart';
import 'package:kualiva/_data/model/pagination/pagination.dart';
import 'package:kualiva/_data/model/pagination/paging.dart';
import 'package:kualiva/common/feature/current_location/current_location_bloc.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/common/utility/sized_utils.dart';
import 'package:kualiva/places/nightlife/bloc/nightlife_nearest_bloc.dart';
import 'package:kualiva/places/nightlife/bloc/nightlife_promo_bloc.dart';
import 'package:kualiva/places/nightlife/feature/nightlife_app_bar_feature.dart';
import 'package:kualiva/places/nightlife/feature/nightlife_nearest_feature.dart';
import 'package:kualiva/places/nightlife/feature/nightlife_promo_feature.dart';

class NightlifeScreen extends StatefulWidget {
  const NightlifeScreen({super.key});

  @override
  State<NightlifeScreen> createState() => _NightlifeScreenState();
}

class _NightlifeScreenState extends State<NightlifeScreen> {
  static const placeCategoryEnum = PlaceCategoryEnum.nightLife;

  final _parentScrollController = ScrollController();
  final _childScrollController = ScrollController();
  final _paging = ValueNotifier(Paging());

  void _onScrollPagination() {
    if (_childScrollController.position.pixels !=
        _childScrollController.position.maxScrollExtent) {
      return;
    }
    final state = context.read<NightlifeNearestBloc>().state;
    if (state is! NightlifeNearestSuccess) return;
    final pagination = state.nightlifeNearestPage.pagination;
    _nextPaging(pagination);
  }

  void _nextPaging(Pagination pagination) {
    if (_paging.value.page == pagination.totalPage) return;
    _paging.value = Paging(
      page: pagination.nextPage ?? pagination.totalPage,
      size: pagination.size,
    );
    final state = context.read<CurrentLocationBloc>().state;
    if (state is! CurrentLocationSuccess) return;
    LeLog.sd(this, _nextPaging, 'Next Paging ${_paging.value}');
    context.read<NightlifeNearestBloc>().add(NightlifeNearestFetched(
          paging: _paging.value,
          pagingEnum: PagingEnum.paged,
          latitude: state.currentLocationModel.latitude,
          longitude: state.currentLocationModel.longitude,
        ));
  }

  @override
  void initState() {
    super.initState();
    _childScrollController.addListener(_onScrollPagination);
  }

  @override
  void dispose() {
    _childScrollController.removeListener(_onScrollPagination);
    _parentScrollController.dispose();
    _childScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CurrentLocationBloc, CurrentLocationState>(
      listener: (context, state) {
        if (state is! CurrentLocationSuccess) return;

        final bool isRefresh = state.isDistanceTooFarOrFirstTime;

        context.read<NightlifePromoBloc>().add(NightlifePromoFetched(
              isRefresh: isRefresh,
              placeCategoryEnum: placeCategoryEnum,
            ));

        final (paging, pagingEnum) = ((isRefresh == true)
            ? (Paging(), PagingEnum.refreshed)
            : (_paging.value, PagingEnum.before));

        context.read<NightlifeNearestBloc>().add(NightlifeNearestFetched(
              paging: paging,
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
              NightlifeNearestFeature(
                parentContext: context,
                parentScrollController: _parentScrollController,
                childScrollController: _childScrollController,
              ),
              SizedBox(height: 5.h),
              NightlifePromoFeature(),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }
}

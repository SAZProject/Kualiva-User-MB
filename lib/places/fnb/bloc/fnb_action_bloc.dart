import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:kualiva/_data/enum/fnb_action_enum.dart';
import 'package:kualiva/_data/enum/paging_enum.dart';
import 'package:kualiva/_data/model/pagination/paging.dart';
import 'package:kualiva/_repository/place/fnb/fnb_nearest_repository.dart';
import 'package:kualiva/_repository/place/fnb/fnb_promo_repository.dart';
import 'package:kualiva/_repository/place/fnb/fnb_recommended_repository.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/places/fnb/model/fnb_nearest_page.dart';
import 'package:kualiva/places/fnb/model/fnb_promo_page.dart';
import 'package:kualiva/places/fnb/model/fnb_recommended_page.dart';

part 'fnb_action_event.dart';
part 'fnb_action_state.dart';

class FnbActionBloc extends Bloc<FnbActionEvent, FnbActionState> {
  final FnbNearestRepository _fnbNearestRepository;
  final FnbPromoRepository _fnbPromoRepository;
  final FnbRecommendedRepository _fnbRecommendedRepository;
  late FnbActionEnum fnbActionEnum;

  FnbActionBloc(
    this._fnbNearestRepository,
    this._fnbPromoRepository,
    this._fnbRecommendedRepository,
  ) : super(FnbActionInitial()) {
    on<FnbActionEvent>((event, emit) {});
    on<FnbActionFetched>(_onFetched);
  }

  Future<Paging> currentPaging() async {
    switch (fnbActionEnum) {
      case FnbActionEnum.nearest:
        return Paging.fromPaginationCurrent(
          _fnbNearestRepository.getNearestOld()!.pagination,
        );
      case FnbActionEnum.promo:
        return Paging.fromPaginationCurrent(
          _fnbPromoRepository.getPromoOld()!.pagination,
        );
      case FnbActionEnum.recommended:
        return Paging.fromPaginationCurrent(
          _fnbRecommendedRepository.getRecommendedOld()!.pagination,
        );
    }
  }

  void _onFetched(
    FnbActionFetched event,
    Emitter<FnbActionState> emit,
  ) async {
    LeLog.bd(this, _onFetched, 'fnbPlaceEnum ${event.fnbActionEnum.name}');
    fnbActionEnum = event.fnbActionEnum;
    switch (event.fnbActionEnum) {
      case FnbActionEnum.nearest:
        await _nearest(event, emit);
        break;
      case FnbActionEnum.promo:
        await _promo(event, emit);
        break;
      case FnbActionEnum.recommended:
        await _recommended(event, emit);
        break;
    }
  }

  Future<void> _nearest(
    FnbActionFetched event,
    Emitter<FnbActionState> emit,
  ) async {
    final fnbNearestPageOld = _fnbNearestRepository.getNearestOld();
    emit(FnbActionLoadingNearest(fnbNearestPage: fnbNearestPageOld));
    try {
      final fnbNearestPage = await _fnbNearestRepository.getNearest(
        paging: event.paging,
        pagingEnum: event.pagingEnum,
        latitude: event.latitude,
        longitude: event.longitude,
      );
      LeLog.bd(this, _nearest, fnbNearestPage.toString());
      emit(FnbActionSuccessNearest(fnbNearestPage: fnbNearestPage));
    } catch (e) {
      LeLog.be(this, _nearest, e.toString());
      emit(FnbActionFailure(fnbActionEnum: event.fnbActionEnum));
    }
  }

  Future<void> _promo(
    FnbActionFetched event,
    Emitter<FnbActionState> emit,
  ) async {
    final fnbPromoPageOld = _fnbPromoRepository.getPromoOld();
    emit(FnbActionLoadingPromo(fnbPromoPage: fnbPromoPageOld));
    try {
      final fnbPromoPage = await _fnbPromoRepository.getPromo(
        paging: event.paging,
        pagingEnum: event.pagingEnum,
        latitude: event.latitude,
        longitude: event.longitude,
      );
      LeLog.bd(this, _promo, fnbPromoPage.toString());
      emit(FnbActionSuccessPromo(fnbPromoPage: fnbPromoPage));
    } catch (e) {
      LeLog.be(this, _promo, e.toString());
      emit(FnbActionFailure(fnbActionEnum: event.fnbActionEnum));
    }
  }

  Future<void> _recommended(
    FnbActionFetched event,
    Emitter<FnbActionState> emit,
  ) async {
    final fnbRecommendedPageOld = _fnbRecommendedRepository.getRecommendedOld();
    emit(
        FnbActionLoadingRecommended(fnbRecommendedPage: fnbRecommendedPageOld));
    try {
      final fnbRecommendedPage = await _fnbRecommendedRepository.getRecommended(
        paging: event.paging,
        pagingEnum: event.pagingEnum,
        latitude: event.latitude,
        longitude: event.longitude,
      );
      LeLog.bd(this, _recommended, fnbRecommendedPage.toString());
      emit(FnbActionSuccessRecommended(fnbRecommendedPage: fnbRecommendedPage));
    } catch (e) {
      LeLog.be(this, _recommended, e.toString());
      emit(FnbActionFailure(fnbActionEnum: event.fnbActionEnum));
    }
  }
}

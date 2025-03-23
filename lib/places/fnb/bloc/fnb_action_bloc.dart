import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:kualiva/_data/enum/fnb_action_enum.dart';
import 'package:kualiva/_data/enum/paging_enum.dart';
import 'package:kualiva/_data/model/pagination/paging.dart';
import 'package:kualiva/_repository/place/fnb/fnb_nearest_repository.dart';
import 'package:kualiva/_repository/place/fnb/fnb_promo_repository.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/places/fnb/model/fnb_nearest_page.dart';
import 'package:kualiva/places/fnb/model/fnb_promo_page.dart';

part 'fnb_action_event.dart';
part 'fnb_action_state.dart';

class FnbActionBloc extends Bloc<FnbActionEvent, FnbActionState> {
  final FnbNearestRepository _fnbNearestRepository;
  final FnbPromoRepository _fnbPromoRepository;
  FnbActionBloc(
    this._fnbNearestRepository,
    this._fnbPromoRepository,
  ) : super(FnbActionInitial()) {
    on<FnbActionEvent>((event, emit) {});
    on<FnbActionFetched>(_onFetched);
  }

  void _onFetched(
    FnbActionFetched event,
    Emitter<FnbActionState> emit,
  ) async {
    LeLog.bd(this, _onFetched, 'fnbPlaceEnum ${event.fnbActionEnum.name}');
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
  ) async {}
}

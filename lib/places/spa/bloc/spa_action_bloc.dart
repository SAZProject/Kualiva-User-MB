import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/_data/enum/paging_enum.dart';
import 'package:kualiva/_data/enum/spa_action_enum.dart';
import 'package:kualiva/_data/model/pagination/paging.dart';
import 'package:kualiva/_repository/place/spa/spa_nearest_repository.dart';
import 'package:kualiva/_repository/place/spa/spa_promo_repository.dart';
import 'package:kualiva/_repository/place/spa/spa_recommended_repository.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/places/spa/model/spa_nearest_page.dart';
import 'package:kualiva/places/spa/model/spa_promo_page.dart';
import 'package:kualiva/places/spa/model/spa_recommended_page.dart';

part 'spa_action_event.dart';
part 'spa_action_state.dart';

class SpaActionBloc extends Bloc<SpaActionEvent, SpaActionState> {
  final SpaNearestRepository _spaNearestRepository;
  final SpaPromoRepository _spaPromoRepository;
  final SpaRecommendedRepository _spaRecommendedRepository;
  SpaActionBloc(
    this._spaNearestRepository,
    this._spaPromoRepository,
    this._spaRecommendedRepository,
  ) : super(SpaActionInitial()) {
    on<SpaActionEvent>((event, emit) {});
    on<SpaActionFetched>(_onFetched);
  }

  void _onFetched(
    SpaActionFetched event,
    Emitter<SpaActionState> emit,
  ) async {
    LeLog.bd(this, _onFetched, 'spaPlaceEnum ${event.spaActionEnum.name}');
    switch (event.spaActionEnum) {
      case SpaActionEnum.nearest:
        await _nearest(event, emit);
        break;
      case SpaActionEnum.promo:
        await _promo(event, emit);
        break;
      case SpaActionEnum.recommended:
        await _recommended(event, emit);
        break;
    }
  }

  Future<void> _nearest(
    SpaActionFetched event,
    Emitter<SpaActionState> emit,
  ) async {
    final spaNearestPageOld = _spaNearestRepository.getNearestOld();
    emit(SpaActionLoadingNearest(spaNearestPage: spaNearestPageOld));
    try {
      final spaNearestPage = await _spaNearestRepository.getNearest(
        paging: event.paging,
        pagingEnum: event.pagingEnum,
        latitude: event.latitude,
        longitude: event.longitude,
      );
      LeLog.bd(this, _nearest, spaNearestPage.toString());
      emit(SpaActionSuccessNearest(spaNearestPage: spaNearestPage));
    } catch (e) {
      LeLog.be(this, _nearest, e.toString());
      emit(SpaActionFailure(spaActionEnum: event.spaActionEnum));
    }
  }

  Future<void> _promo(
    SpaActionFetched event,
    Emitter<SpaActionState> emit,
  ) async {
    final spaPromoPageOld = _spaPromoRepository.getPromoOld();
    emit(SpaActionLoadingPromo(spaPromoPage: spaPromoPageOld));
    try {
      final spaPromoPage = await _spaPromoRepository.getPromo(
        paging: event.paging,
        pagingEnum: event.pagingEnum,
        latitude: event.latitude,
        longitude: event.longitude,
      );
      LeLog.bd(this, _promo, spaPromoPage.toString());
      emit(SpaActionSuccessPromo(spaPromoPage: spaPromoPage));
    } catch (e) {
      LeLog.be(this, _promo, e.toString());
      emit(SpaActionFailure(spaActionEnum: event.spaActionEnum));
    }
  }

  Future<void> _recommended(
    SpaActionFetched event,
    Emitter<SpaActionState> emit,
  ) async {
    final spaRecommendedPageOld = _spaRecommendedRepository.getRecommendedOld();
    emit(
        SpaActionLoadingRecommended(spaRecommendedPage: spaRecommendedPageOld));
    try {
      final spaRecommendedPage = await _spaRecommendedRepository.getRecommended(
        paging: event.paging,
        pagingEnum: event.pagingEnum,
        latitude: event.latitude,
        longitude: event.longitude,
      );
      LeLog.bd(this, _recommended, spaRecommendedPage.toString());
      emit(SpaActionSuccessRecommended(spaRecommendedPage: spaRecommendedPage));
    } catch (e) {
      LeLog.be(this, _recommended, e.toString());
      emit(SpaActionFailure(spaActionEnum: event.spaActionEnum));
    }
  }
}

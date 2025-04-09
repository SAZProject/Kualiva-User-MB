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
  late SpaActionEnum spaActionEnum;
  String? searchName;

  SpaActionBloc(
    this._spaNearestRepository,
    this._spaPromoRepository,
    this._spaRecommendedRepository,
  ) : super(SpaActionInitial()) {
    on<SpaActionEvent>((event, emit) {});
    on<SpaActionFetched>(_onFetched);
  }

  Future<Paging> currentPaging() async {
    switch (spaActionEnum) {
      case SpaActionEnum.nearest:
        return Paging.fromPaginationCurrent(
          _spaNearestRepository.getNearestOld(searchName)!.pagination,
        );
      case SpaActionEnum.promo:
        return Paging.fromPaginationCurrent(
          _spaPromoRepository.getPromoOld(searchName)!.pagination,
        );
      case SpaActionEnum.recommended:
        return Paging.fromPaginationCurrent(
          _spaRecommendedRepository.getRecommendedOld(searchName)!.pagination,
        );
    }
  }

  void _onFetched(
    SpaActionFetched event,
    Emitter<SpaActionState> emit,
  ) async {
    spaActionEnum = event.spaActionEnum;
    searchName = event.name;
    LeLog.bd(this, _onFetched,
        'spaActionEnum [${spaActionEnum.name}], searchName [$searchName]');
    switch (spaActionEnum) {
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
    final spaNearestPageOld = _spaNearestRepository.getNearestOld(searchName);
    emit(SpaActionLoadingNearest(spaNearestPage: spaNearestPageOld));
    try {
      final spaNearestPage = await _spaNearestRepository.getNearest(
        paging: event.paging,
        pagingEnum: event.pagingEnum,
        latitude: event.latitude,
        longitude: event.longitude,
        name: searchName,
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
    final spaPromoPageOld = _spaPromoRepository.getPromoOld(searchName);
    emit(SpaActionLoadingPromo(spaPromoPage: spaPromoPageOld));
    try {
      final spaPromoPage = await _spaPromoRepository.getPromo(
        paging: event.paging,
        pagingEnum: event.pagingEnum,
        latitude: event.latitude,
        longitude: event.longitude,
        name: searchName,
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
    final spaRecommendedPageOld =
        _spaRecommendedRepository.getRecommendedOld(searchName);
    emit(
        SpaActionLoadingRecommended(spaRecommendedPage: spaRecommendedPageOld));
    try {
      final spaRecommendedPage = await _spaRecommendedRepository.getRecommended(
        paging: event.paging,
        pagingEnum: event.pagingEnum,
        latitude: event.latitude,
        longitude: event.longitude,
        name: searchName,
      );
      LeLog.bd(this, _recommended, spaRecommendedPage.toString());
      emit(SpaActionSuccessRecommended(spaRecommendedPage: spaRecommendedPage));
    } catch (e) {
      LeLog.be(this, _recommended, e.toString());
      emit(SpaActionFailure(spaActionEnum: event.spaActionEnum));
    }
  }
}

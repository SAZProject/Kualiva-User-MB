import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:kualiva/_data/enum/nightlife_action_enum.dart';
import 'package:kualiva/_data/enum/paging_enum.dart';
import 'package:kualiva/_data/model/pagination/paging.dart';
import 'package:kualiva/_repository/place/nightlife/nightlife_nearest_repository.dart';
import 'package:kualiva/_repository/place/nightlife/nightlife_promo_repository.dart';
import 'package:kualiva/_repository/place/nightlife/nightlife_recommended_repository.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/places/nightlife/model/nightlife_nearest_page.dart';
import 'package:kualiva/places/nightlife/model/nightlife_promo_page.dart';
import 'package:kualiva/places/nightlife/model/nightlife_recommended_page.dart';

part 'nightlife_action_event.dart';
part 'nightlife_action_state.dart';

class NightlifeActionBloc
    extends Bloc<NightlifeActionEvent, NightlifeActionState> {
  final NightlifeNearestRepository _nightlifeNearestRepository;
  final NightlifePromoRepository _nightlifePromoRepository;
  final NightlifeRecommendedRepository _nightlifeRecommendedRepository;
  late NightlifeActionEnum nightlifeActionEnum;
  String? searchName;

  NightlifeActionBloc(
    this._nightlifeNearestRepository,
    this._nightlifePromoRepository,
    this._nightlifeRecommendedRepository,
  ) : super(NightlifeActionInitial()) {
    on<NightlifeActionEvent>((event, emit) {});
    on<NightlifeActionFetched>(_onFetched);
  }

  Future<Paging> currentPaging() async {
    switch (nightlifeActionEnum) {
      case NightlifeActionEnum.nearest:
        return Paging.fromPaginationCurrent(
          _nightlifeNearestRepository.getNearestOld(searchName)!.pagination,
        );
      case NightlifeActionEnum.promo:
        return Paging.fromPaginationCurrent(
          _nightlifePromoRepository.getPromoOld(searchName)!.pagination,
        );
      case NightlifeActionEnum.recommended:
        return Paging.fromPaginationCurrent(
          _nightlifeRecommendedRepository
              .getRecommendedOld(searchName)!
              .pagination,
        );
    }
  }

  void _onFetched(
    NightlifeActionFetched event,
    Emitter<NightlifeActionState> emit,
  ) async {
    nightlifeActionEnum = event.nightlifeActionEnum;
    searchName = event.name;
    LeLog.bd(this, _onFetched,
        'nightlifeActionEnum [${nightlifeActionEnum.name}], searchName [$searchName]');
    switch (event.nightlifeActionEnum) {
      case NightlifeActionEnum.nearest:
        await _nearest(event, emit);
        break;
      case NightlifeActionEnum.promo:
        await _promo(event, emit);
        break;
      case NightlifeActionEnum.recommended:
        await _recommended(event, emit);
        break;
    }
  }

  Future<void> _nearest(
    NightlifeActionFetched event,
    Emitter<NightlifeActionState> emit,
  ) async {
    final nightlifeNearestPageOld =
        _nightlifeNearestRepository.getNearestOld(searchName);
    emit(NightlifeActionLoadingNearest(
        nightlifeNearestPage: nightlifeNearestPageOld));
    try {
      final nightlifeNearestPage = await _nightlifeNearestRepository.getNearest(
        paging: event.paging,
        pagingEnum: event.pagingEnum,
        latitude: event.latitude,
        longitude: event.longitude,
        name: searchName,
      );
      LeLog.bd(this, _onFetched, nightlifeNearestPage.toString());
      emit(NightlifeActionSuccessNearest(
          nightlifeNearestPage: nightlifeNearestPage));
    } catch (e) {
      LeLog.be(this, _nearest, e.toString());
      emit(NightlifeActionFailure(
          nightlifeActionEnum: event.nightlifeActionEnum));
    }
  }

  Future<void> _promo(
    NightlifeActionFetched event,
    Emitter<NightlifeActionState> emit,
  ) async {
    final nightlifePromoPageOld =
        _nightlifePromoRepository.getPromoOld(searchName);
    emit(
        NightlifeActionLoadingPromo(nightlifePromoPage: nightlifePromoPageOld));
    try {
      final nightlifePromoPage = await _nightlifePromoRepository.getPromo(
        paging: event.paging,
        pagingEnum: event.pagingEnum,
        latitude: event.latitude,
        longitude: event.longitude,
        name: searchName,
      );
      LeLog.bd(this, _promo, nightlifePromoPage.toString());
      emit(NightlifeActionSuccessPromo(nightlifePromoPage: nightlifePromoPage));
    } catch (e) {
      LeLog.be(this, _promo, e.toString());
      emit(NightlifeActionFailure(
          nightlifeActionEnum: event.nightlifeActionEnum));
    }
  }

  Future<void> _recommended(
    NightlifeActionFetched event,
    Emitter<NightlifeActionState> emit,
  ) async {
    final nightlifeRecommendedPageOld =
        _nightlifeRecommendedRepository.getRecommendedOld(searchName);
    emit(NightlifeActionLoadingRecommended(
        nightlifeRecommendedPage: nightlifeRecommendedPageOld));
    try {
      final nightlifeRecommendedPage =
          await _nightlifeRecommendedRepository.getRecommended(
        paging: event.paging,
        pagingEnum: event.pagingEnum,
        latitude: event.latitude,
        longitude: event.longitude,
        name: searchName,
      );
      LeLog.bd(this, _recommended, nightlifeRecommendedPage.toString());
      emit(NightlifeActionSuccessRecommended(
          nightlifeRecommendedPage: nightlifeRecommendedPage));
    } catch (e) {
      LeLog.be(this, _recommended, e.toString());
      emit(NightlifeActionFailure(
          nightlifeActionEnum: event.nightlifeActionEnum));
    }
  }
}

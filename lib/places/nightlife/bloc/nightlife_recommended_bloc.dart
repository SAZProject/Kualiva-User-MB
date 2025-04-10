import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:kualiva/_data/enum/paging_enum.dart';
import 'package:kualiva/_data/model/pagination/paging.dart';
import 'package:kualiva/_repository/place/nightlife/nightlife_recommended_repository.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/places/nightlife/model/nightlife_recommended_page.dart';

part 'nightlife_recommended_event.dart';
part 'nightlife_recommended_state.dart';

class NightlifeRecommendedBloc
    extends Bloc<NightlifeRecommendedEvent, NightlifeRecommendedState> {
  final NightlifeRecommendedRepository _nightlifeRecommendedRepository;
  NightlifeRecommendedBloc(this._nightlifeRecommendedRepository)
      : super(NightlifeRecommendedInitial()) {
    on<NightlifeRecommendedEvent>((event, emit) {});
    on<NightlifeRecommendedFetched>(_onFetched);
  }

  void _onFetched(
    NightlifeRecommendedFetched event,
    Emitter<NightlifeRecommendedState> emit,
  ) async {
    final nightlifeRecommendedPageOld =
        _nightlifeRecommendedRepository.getRecommendedOld(null);
    emit(NightlifeRecommendedLoading(
        nightlifeRecommendedPage: nightlifeRecommendedPageOld));
    try {
      final nightlifeRecommendedPage =
          await _nightlifeRecommendedRepository.getRecommended(
        paging: event.paging,
        pagingEnum: event.pagingEnum,
        latitude: event.latitude,
        longitude: event.longitude,
      );
      LeLog.bd(this, _onFetched, nightlifeRecommendedPage.toString());
      emit(NightlifeRecommendedSuccess(
          nightlifeRecommendedPage: nightlifeRecommendedPage));
    } catch (e) {
      LeLog.be(this, _onFetched, e.toString());
      emit(NightlifeRecommendedFailure());
    }
  }
}

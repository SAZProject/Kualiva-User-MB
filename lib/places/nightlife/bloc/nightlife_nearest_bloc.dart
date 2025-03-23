import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:kualiva/_data/enum/paging_enum.dart';
import 'package:kualiva/_data/model/pagination/paging.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/_repository/place/nightlife_repository.dart';
import 'package:kualiva/places/nightlife/model/nightlife_nearest_page.dart';

part 'nightlife_nearest_event.dart';
part 'nightlife_nearest_state.dart';

class NightlifeNearestBloc
    extends Bloc<NightlifeNearestEvent, NightlifeNearestState> {
  final NightlifeRepository _nightlifeRepository;
  NightlifeNearestBloc(this._nightlifeRepository)
      : super(NightlifeNearestInitial()) {
    on<NightlifeNearestEvent>((event, emit) => {});
    on<NightlifeNearestFetched>(_onFetched);
  }

  void _onFetched(
    NightlifeNearestFetched event,
    Emitter<NightlifeNearestState> emit,
  ) async {
    try {
      final nightlifeNearestPageOld =
          _nightlifeRepository.getPlacesNearestOld();
      emit(NightlifeNearestLoading(
        nightlifeNearestPage: nightlifeNearestPageOld,
      ));
      final nightlifeNearestPage = await _nightlifeRepository.getPlacesNearest(
        paging: event.paging,
        pagingEnum: event.pagingEnum,
        latitude: event.latitude,
        longitude: event.longitude,
      );
      LeLog.bd(this, _onFetched, nightlifeNearestPage.toString());
      emit(NightlifeNearestSuccess(nightlifeNearestPage: nightlifeNearestPage));
    } catch (e) {
      LeLog.be(this, _onFetched, e.toString());
      emit(NightlifeNearestFailure());
    }
  }
}

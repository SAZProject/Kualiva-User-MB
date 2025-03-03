import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/_repository/nightlife_repository.dart';
import 'package:kualiva/places/nightlife/model/nightlife_nearest_model.dart';

part 'nightlife_nearest_event.dart';
part 'nightlife_nearest_state.dart';

class NightlifeNearestBloc
    extends Bloc<NightlifeNearestEvent, NightlifeNearestState> {
  final NightlifeRepository _nightlifeRepository;
  NightlifeNearestBloc(this._nightlifeRepository)
      : super(NightlifeNearestInitial()) {
    on<NightlifeNearestEvent>((event, emit) => emit(NightlifeNearestLoading()));
    on<NightlifeNearestFetched>(_onFetched);
  }

  void _onFetched(
    NightlifeNearestFetched event,
    Emitter<NightlifeNearestState> emit,
  ) async {
    try {
      final List<NightlifeNearestModel> nearest =
          await _nightlifeRepository.getPlacesNearest(
        latitude: event.latitude,
        longitude: event.longitude,
      );
      LeLog.bd(this, _onFetched, nearest.toString());
      emit(NightlifeNearestSuccess(nearest: nearest));
    } catch (e) {
      LeLog.be(this, _onFetched, e.toString());
      emit(NightlifeNearestFailure());
    }
  }
}

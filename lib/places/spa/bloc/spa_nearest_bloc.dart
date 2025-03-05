import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:kualiva/_repository/spa_repository.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/places/spa/model/spa_nearest_model.dart';

part 'spa_nearest_event.dart';
part 'spa_nearest_state.dart';

class SpaNearestBloc extends Bloc<SpaNearestEvent, SpaNearestState> {
  final SpaRepository _spaRepository;
  SpaNearestBloc(this._spaRepository) : super(SpaNearestInitial()) {
    on<SpaNearestEvent>((event, emit) => emit(SpaNearestLoading()));
    on<SpaNearestFetched>(_onFetched);
  }

  void _onFetched(
    SpaNearestFetched event,
    Emitter<SpaNearestState> emit,
  ) async {
    try {
      final List<SpaNearestModel> nearest =
          await _spaRepository.getPlacesNearest(
        latitude: event.latitude,
        longitude: event.longitude,
      );
      LeLog.bd(this, _onFetched, nearest.toString());
      emit(SpaNearestSuccess(nearest: nearest));
    } catch (e) {
      LeLog.be(this, _onFetched, e.toString());
      emit(SpaNearestFailure());
    }
  }
}

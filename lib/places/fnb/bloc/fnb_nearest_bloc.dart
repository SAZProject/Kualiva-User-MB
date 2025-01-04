import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/places/fnb/model/fnb_nearest_model.dart';
import 'package:kualiva/repository/fnb_repository.dart';

part 'fnb_nearest_event.dart';
part 'fnb_nearest_state.dart';

class FnbNearestBloc extends Bloc<FnbNearestEvent, FnbNearestState> {
  final FnbRepository _fnbRepository;
  FnbNearestBloc(this._fnbRepository) : super(FnbNearestInitial()) {
    on<FnbNearestEvent>((event, emit) => emit(FnbNearestLoading()));
    on<FnbNearestStarted>(_onStarted);
    on<FnbNearestFetched>(_onFetched);
  }

  void _onStarted(
    FnbNearestStarted event,
    Emitter<FnbNearestState> emit,
  ) {
    LeLog.bd(this, _onStarted, 'On Started');
    emit(FnbNearestInitial());
  }

  void _onFetched(
    FnbNearestFetched event,
    Emitter<FnbNearestState> emit,
  ) async {
    try {
      final List<FnbNearestModel> nearest =
          await _fnbRepository.getPlacesNearest(
        latitude: event.latitude,
        longitude: event.longitude,
      );
      LeLog.bd(this, _onFetched, nearest.toString());
      emit(FnbNearestSuccess(nearest: nearest));
    } catch (e) {
      LeLog.be(this, _onFetched, e.toString());
      emit(FnbNearestFailure());
    }
  }
}

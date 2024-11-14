import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:like_it/common/utility/location_util.dart';
import 'package:like_it/data/current_location/current_location_model.dart';

part 'current_location_event.dart';
part 'current_location_state.dart';

class CurrentLocationBloc
    extends Bloc<CurrentLocationEvent, CurrentLocationState> {
  CurrentLocationBloc() : super(CurrentLocationInitial()) {
    on<CurrentLocationEvent>((event, emit) => emit(CurrentLocationLoading()));
    on<CurrentLocationStarted>(_onStarted);
    on<CurrentLocationNoPermission>(_onNoPermission);
  }

  void _onStarted(
    CurrentLocationStarted event,
    Emitter<CurrentLocationState> emit,
  ) async {
    try {
      final res = await LocationUtil.getUserCurrentLocation();
      emit(CurrentLocationSuccess(currentLocationModel: res));
    } catch (e) {
      emit(CurrentLocationFailure(message: e.toString()));
    }
  }

  void _onNoPermission(
    CurrentLocationNoPermission event,
    Emitter<CurrentLocationState> emit,
  ) async {
    emit(CurrentLocationFailure(message: event.message));
  }
}

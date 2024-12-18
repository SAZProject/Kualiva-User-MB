import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/common/utility/location_util.dart';
import 'package:kualiva/data/current_location/current_location_model.dart';

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
      final currentLocation = await LocationUtil.getUserCurrentLocation();
      LeLog.bd(this, _onStarted, currentLocation.toString());
      emit(CurrentLocationSuccess(currentLocationModel: currentLocation));
    } catch (e) {
      LeLog.bd(this, _onStarted, e.toString());
      emit(CurrentLocationFailure(message: e.toString()));
    }
  }

  void _onNoPermission(
    CurrentLocationNoPermission event,
    Emitter<CurrentLocationState> emit,
  ) async {
    LeLog.bd(this, _onStarted, event.message.toString());
    emit(CurrentLocationFailure(message: event.message));
  }
}

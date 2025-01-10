import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:kualiva/_repository/location_repository.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/_data/feature/current_location/current_location_model.dart';

part 'current_location_event.dart';
part 'current_location_state.dart';

class CurrentLocationBloc
    extends Bloc<CurrentLocationEvent, CurrentLocationState> {
  final LocationRepository _locationRepository;
  CurrentLocationBloc(this._locationRepository)
      : super(CurrentLocationInitial()) {
    on<CurrentLocationEvent>((event, emit) {});
    on<CurrentLocationFetched>(_onFetched);
    on<CurrentLocationNoPermission>(_onNoPermission);
  }

  void _onFetched(
    CurrentLocationFetched event,
    Emitter<CurrentLocationState> emit,
  ) async {
    try {
      final oldLocation = _locationRepository.oldLocation();
      final newLocation = await _locationRepository.newLocation();

      final isTriggerEmit =
          await _locationRepository.isDistanceTooFarOrFirstTime(
        oldLocation: oldLocation,
        newLocation: newLocation,
      );
      LeLog.bd(this, _onFetched, isTriggerEmit.toString());
      if (isTriggerEmit) {
        LeLog.bd(this, _onFetched, newLocation.toString());
        emit(CurrentLocationSuccess(currentLocationModel: newLocation));
      }
    } catch (e) {
      LeLog.be(this, _onFetched, e.toString());
      emit(CurrentLocationFailure(message: e.toString()));
    }
  }

  void _onNoPermission(
    CurrentLocationNoPermission event,
    Emitter<CurrentLocationState> emit,
  ) async {
    LeLog.be(this, _onNoPermission, 'No Connection or error on locator');
    emit(CurrentLocationFailure(message: 'No Connection or error on locator'));
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/places/fnb/model/fnb_nearest_model.dart';
import 'package:kualiva/_repository/fnb_repository.dart';

part 'hotel_nearest_event.dart';
part 'hotel_nearest_state.dart';

class HotelNearestBloc extends Bloc<HotelNearestEvent, HotelNearestState> {
  final FnbRepository _fnbRepository;
  HotelNearestBloc(this._fnbRepository) : super(HotelNearestInitial()) {
    on<HotelNearestEvent>((event, emit) => emit(HotelNearestLoading()));
    on<HotelNearestStarted>(_onStarted);
    on<HotelNearestFetched>(_onFetched);
  }

  void _onStarted(
    HotelNearestStarted event,
    Emitter<HotelNearestState> emit,
  ) {
    LeLog.bd(this, _onStarted, 'On Started');
    emit(HotelNearestInitial());
  }

  void _onFetched(
    HotelNearestFetched event,
    Emitter<HotelNearestState> emit,
  ) async {
    try {
      final List<FnbNearestModel> nearest =
          await _fnbRepository.getPlacesNearestHotel(
        latitude: event.latitude,
        longitude: event.longitude,
      );
      LeLog.bd(this, _onFetched, nearest.toString());
      emit(HotelNearestSuccess(nearest: nearest));
    } catch (e) {
      LeLog.be(this, _onFetched, e.toString());
      emit(HotelNearestFailure());
    }
  }
}

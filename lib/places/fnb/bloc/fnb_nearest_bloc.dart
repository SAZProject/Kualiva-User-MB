import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:like_it/common/utility/lelog.dart';
import 'package:like_it/places/fnb/model/fnb_nearest_model.dart';
import 'package:like_it/places/fnb/repository/fnb_repository.dart';

part 'fnb_nearest_event.dart';
part 'fnb_nearest_state.dart';

class FnbNearestBloc extends Bloc<FnbNearestEvent, FnbNearestState> {
  final FnbRepository _fnbRepository;
  FnbNearestBloc(this._fnbRepository) : super(FnbNearestInitial()) {
    // on<FnbNearestEvent>((event, emit) {});
    on<FnbNearestStarted>(_started);
    on<FnbNearestFetched>(_fetched);
  }

  void _started(
    FnbNearestStarted event,
    Emitter<FnbNearestState> emit,
  ) {
    emit(FnbNearestInitial());
  }

  void _fetched(
    FnbNearestFetched event,
    Emitter<FnbNearestState> emit,
  ) async {
    LeLog.d(this, "loading");
    emit(FnbNearestLoading());
    try {
      LeLog.d(this, "try");
      final List<FnbNearestModel> nearest =
          await _fnbRepository.getMerchantNearest(
        latitude: event.latitude,
        longitude: event.longitude,
      );
      LeLog.d(this, "aaaa");
      debugPrint(nearest.toString());
      emit(FnbNearestSuccess(nearest: nearest));
    } catch (e) {
      emit(FnbNearestFailure());
    }
  }
}

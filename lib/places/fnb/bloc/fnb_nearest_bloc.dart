import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:kualiva/_data/enum/paging_enum.dart';
import 'package:kualiva/_data/model/pagination/paging.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/_repository/place/fnb_repository.dart';
import 'package:kualiva/places/fnb/model/fnb_nearest_page.dart';

part 'fnb_nearest_event.dart';
part 'fnb_nearest_state.dart';

class FnbNearestBloc extends Bloc<FnbNearestEvent, FnbNearestState> {
  final FnbRepository _fnbRepository;
  FnbNearestBloc(this._fnbRepository) : super(FnbNearestInitial()) {
    on<FnbNearestEvent>((event, emit) => emit(FnbNearestLoading()));
    on<FnbNearestFetched>(_onFetched);
  }

  void _onFetched(
    FnbNearestFetched event,
    Emitter<FnbNearestState> emit,
  ) async {
    try {
      final fnbNearestPage = await _fnbRepository.getPlacesNearest(
        paging: event.paging,
        pagingEnum: event.pagingEnum,
        latitude: event.latitude,
        longitude: event.longitude,
      );
      LeLog.bd(this, _onFetched, fnbNearestPage.toString());
      emit(FnbNearestSuccess(fnbNearestPage: fnbNearestPage));
    } catch (e) {
      LeLog.be(this, _onFetched, e.toString());
      emit(FnbNearestFailure());
    }
  }
}

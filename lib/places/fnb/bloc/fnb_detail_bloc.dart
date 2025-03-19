import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/places/fnb/model/fnb_detail_model.dart';
import 'package:kualiva/_repository/place/fnb_repository.dart';

part 'fnb_detail_event.dart';
part 'fnb_detail_state.dart';

class FnbDetailBloc extends Bloc<FnbDetailEvent, FnbDetailState> {
  final FnbRepository _fnbRepository;

  FnbDetailBloc(this._fnbRepository) : super(FnbDetailInitial()) {
    on<FnbDetailEvent>((event, emit) => emit(FnbDetailLoading()));
    on<FnbDetailFetched>(_onFetched);
  }

  void _onFetched(
    FnbDetailFetched event,
    Emitter<FnbDetailState> emit,
  ) async {
    try {
      final FnbDetailModel fnbDetail = await _fnbRepository.getPlaceDetail(
        placeId: event.placeId,
      );
      LeLog.bd(this, _onFetched, fnbDetail.toString());
      emit(FnbDetailSuccess(fnbDetail: fnbDetail));
    } catch (e) {
      LeLog.be(this, _onFetched, e.toString());
      emit(FnbDetailFailure());
    }
  }
}

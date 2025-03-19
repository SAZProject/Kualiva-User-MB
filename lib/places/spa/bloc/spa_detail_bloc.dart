import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/_repository/place/spa_repository.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/places/spa/model/spa_detail_model.dart';

part 'spa_detail_event.dart';
part 'spa_detail_state.dart';

class SpaDetailBloc extends Bloc<SpaDetailEvent, SpaDetailState> {
  final SpaRepository _spaRepository;

  SpaDetailBloc(this._spaRepository) : super(SpaDetailInitial()) {
    on<SpaDetailEvent>((event, emit) => emit(SpaDetailLoading()));
    on<SpaDetailFetched>(_onFetched);
  }

  void _onFetched(
    SpaDetailFetched event,
    Emitter<SpaDetailState> emit,
  ) async {
    try {
      final SpaDetailModel spaDetail =
          await _spaRepository.getPlaceDetail(placeId: event.placeId);
      LeLog.bd(this, _onFetched, spaDetail.toString());
      emit(SpaDetailSuccess(spaDetail: spaDetail));
    } catch (e) {
      LeLog.be(this, _onFetched, e.toString());
      emit(SpaDetailFailure());
    }
  }
}

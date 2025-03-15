import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/_repository/place/nightlife_repository.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/places/nightlife/model/nightlife_detail_model.dart';

part 'nightlife_detail_event.dart';
part 'nightlife_detail_state.dart';

class NightlifeDetailBloc
    extends Bloc<NightlifeDetailEvent, NightlifeDetailState> {
  final NightlifeRepository _nightlifeRepository;

  NightlifeDetailBloc(this._nightlifeRepository)
      : super(NightlifeDetailInitial()) {
    on<NightlifeDetailEvent>((event, emit) => emit(NightlifeDetailLoading()));
    on<NightlifeDetailFetched>(_onFetched);
  }

  void _onFetched(
    NightlifeDetailFetched event,
    Emitter<NightlifeDetailState> emit,
  ) async {
    try {
      final NightlifeDetailModel nightLifeDetail =
          await _nightlifeRepository.getPlaceDetail(placeId: event.placeId);
      LeLog.bd(this, _onFetched, nightLifeDetail.toString());
      emit(NightlifeDetailSuccess(nightlifeDetail: nightLifeDetail));
    } catch (e) {
      LeLog.be(this, _onFetched, e.toString());
      emit(NightlifeDetailFailure());
    }
  }
}

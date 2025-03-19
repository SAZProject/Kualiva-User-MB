import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/_data/enum/place_category_enum.dart';
import 'package:kualiva/_data/error_handler.dart';
import 'package:kualiva/_repository/place/nightlife_repository.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/places/nightlife/model/nightlife_promo_model.dart';
import 'package:flutter/foundation.dart';

part 'nightlife_promo_event.dart';
part 'nightlife_promo_state.dart';

class NightlifePromoBloc
    extends Bloc<NightlifePromoEvent, NightlifePromoState> {
  final NightlifeRepository _nightlifeRepository;
  NightlifePromoBloc(this._nightlifeRepository)
      : super(NightlifePromoInitial()) {
    on<NightlifePromoEvent>((event, emit) => emit(NightlifePromoLoading()));
    on<NightlifePromoFetched>(_onFetched);
  }

  void _onFetched(
    NightlifePromoFetched event,
    Emitter<NightlifePromoState> emit,
  ) async {
    try {
      final nightlifePromoModels = await _nightlifeRepository.getPromos(
        placeCategoryEnum: event.placeCategoryEnum,
      );
      LeLog.bd(this, _onFetched, nightlifePromoModels.toString());
      emit(NightlifePromoSuccess(nightlifePromoModels: nightlifePromoModels));
    } on Failure catch (e) {
      LeLog.be(this, _onFetched, e.toString());
      emit(NightlifePromoFailure(failure: e));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:kualiva/_repository/nightlife_repository.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/places/nightlife/model/nightlife_promo_model.dart';

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
      final List<NightlifePromoModel> promo =
          await _nightlifeRepository.getPlacesPromo();
      LeLog.bd(this, _onFetched, promo.toString());
      emit(NightlifePromoSuccess(promo: promo));
    } catch (e) {
      LeLog.be(this, _onFetched, e.toString());
      emit(NightlifePromoFailure());
    }
  }
}

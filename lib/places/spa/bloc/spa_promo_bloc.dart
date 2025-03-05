import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/_data/enum/place_category_enum.dart';
import 'package:kualiva/_data/error_handler.dart';
import 'package:kualiva/_repository/spa_repository.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:flutter/foundation.dart';
import 'package:kualiva/places/spa/model/spa_promo_model.dart';

part 'spa_promo_event.dart';
part 'spa_promo_state.dart';

class SpaPromoBloc extends Bloc<SpaPromoEvent, SpaPromoState> {
  final SpaRepository _spaRepository;
  SpaPromoBloc(this._spaRepository) : super(SpaPromoInitial()) {
    on<SpaPromoEvent>((event, emit) => emit(SpaPromoLoading()));
    on<SpaPromoFetched>(_onFetched);
  }

  void _onFetched(
    SpaPromoFetched event,
    Emitter<SpaPromoState> emit,
  ) async {
    try {
      final spaPromoModels = await _spaRepository.getPromos(
        placeCategoryEnum: event.placeCategoryEnum,
      );
      LeLog.bd(this, _onFetched, spaPromoModels.toString());
      emit(SpaPromoSuccess(spaPromoModels: spaPromoModels));
    } on Failure catch (e) {
      LeLog.be(this, _onFetched, e.toString());
      emit(SpaPromoFailure(failure: e));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/_data/enum/place_category_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:kualiva/_data/error_handler.dart';
import 'package:kualiva/_repository/fnb_repository.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/places/fnb/model/fnb_promo_model.dart';

part 'fnb_promo_event.dart';
part 'fnb_promo_state.dart';

class FnbPromoBloc extends Bloc<FnbPromoEvent, FnbPromoState> {
  final FnbRepository _fnbRepository;
  FnbPromoBloc(this._fnbRepository) : super(FnbPromoInitial()) {
    on<FnbPromoEvent>((event, emit) => emit(FnbPromoLoading()));
    on<FnbPromoFetched>(_onFetched);
  }

  void _onFetched(
    FnbPromoFetched event,
    Emitter<FnbPromoState> emit,
  ) async {
    try {
      final fnbPromoModels = await _fnbRepository.getPromos(
        placeCategoryEnum: event.placeCategoryEnum,
      );
      LeLog.bd(this, _onFetched, fnbPromoModels.toString());
      emit(FnbPromoSuccess(fnbPromoModels: fnbPromoModels));
    } on Failure catch (e) {
      LeLog.be(this, _onFetched, e.toString());
      emit(FnbPromoFailure(failure: e));
    }
  }
}

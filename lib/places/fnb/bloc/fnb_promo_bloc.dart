import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/_data/enum/paging_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:kualiva/_data/model/pagination/paging.dart';
import 'package:kualiva/_repository/place/fnb/fnb_promo_repository.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/places/fnb/model/fnb_promo_page.dart';

part 'fnb_promo_event.dart';
part 'fnb_promo_state.dart';

class FnbPromoBloc extends Bloc<FnbPromoEvent, FnbPromoState> {
  final FnbPromoRepository _fnbPromoRepository;
  FnbPromoBloc(
    this._fnbPromoRepository,
  ) : super(FnbPromoInitial()) {
    on<FnbPromoEvent>((event, emit) => {});
    on<FnbPromoFetched>(_onFetched);
  }

  void _onFetched(
    FnbPromoFetched event,
    Emitter<FnbPromoState> emit,
  ) async {
    final fnbPromoPageOld = _fnbPromoRepository.getPromoOld(null);
    emit(FnbPromoLoading(fnbPromoPage: fnbPromoPageOld));
    try {
      final fnbPromoPage = await _fnbPromoRepository.getPromo(
        paging: event.paging,
        pagingEnum: event.pagingEnum,
        latitude: event.latitude,
        longitude: event.longitude,
      );
      LeLog.bd(this, _onFetched, fnbPromoPage.toString());
      emit(FnbPromoSuccess(fnbPromoPage: fnbPromoPage));
    } catch (e) {
      LeLog.be(this, _onFetched, e.toString());
      emit(FnbPromoFailure());
    }
  }
}

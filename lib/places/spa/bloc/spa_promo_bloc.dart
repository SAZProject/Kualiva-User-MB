import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/_data/enum/paging_enum.dart';
import 'package:kualiva/_data/model/pagination/paging.dart';
import 'package:kualiva/_repository/place/spa/spa_promo_repository.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:flutter/foundation.dart';
import 'package:kualiva/places/spa/model/spa_promo_page.dart';

part 'spa_promo_event.dart';
part 'spa_promo_state.dart';

class SpaPromoBloc extends Bloc<SpaPromoEvent, SpaPromoState> {
  final SpaPromoRepository _spaPromoRepository;
  SpaPromoBloc(this._spaPromoRepository) : super(SpaPromoInitial()) {
    on<SpaPromoEvent>((event, emit) => {});
    on<SpaPromoFetched>(_onFetched);
  }

  void _onFetched(
    SpaPromoFetched event,
    Emitter<SpaPromoState> emit,
  ) async {
    final spaPromoPageOld = _spaPromoRepository.getPromoOld(null);
    emit(SpaPromoLoading(spaPromoPage: spaPromoPageOld));
    try {
      final spaPromoPage = await _spaPromoRepository.getPromo(
        paging: event.paging,
        pagingEnum: event.pagingEnum,
        latitude: event.latitude,
        longitude: event.longitude,
      );
      LeLog.bd(this, _onFetched, spaPromoPage.toString());
      emit(SpaPromoSuccess(spaPromoPage: spaPromoPage));
    } catch (e) {
      LeLog.be(this, _onFetched, e.toString());
      emit(SpaPromoFailure());
    }
  }
}

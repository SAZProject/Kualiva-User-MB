import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/_data/enum/paging_enum.dart';
import 'package:kualiva/_data/model/pagination/paging.dart';
import 'package:kualiva/_repository/place/nightlife/nightlife_promo_repository.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:flutter/foundation.dart';
import 'package:kualiva/places/nightlife/model/nightlife_promo_page.dart';

part 'nightlife_promo_event.dart';
part 'nightlife_promo_state.dart';

class NightlifePromoBloc
    extends Bloc<NightlifePromoEvent, NightlifePromoState> {
  final NightlifePromoRepository _nightlifePromoRepository;
  NightlifePromoBloc(this._nightlifePromoRepository)
      : super(NightlifePromoInitial()) {
    on<NightlifePromoEvent>((event, emit) => {});
    on<NightlifePromoFetched>(_onFetched);
  }

  void _onFetched(
    NightlifePromoFetched event,
    Emitter<NightlifePromoState> emit,
  ) async {
    final nightlifePromoPageOld = _nightlifePromoRepository.getPromoOld();
    emit(NightlifePromoLoading(nightlifePromoPage: nightlifePromoPageOld));
    try {
      final nightlifePromoPage = await _nightlifePromoRepository.getPromo(
        paging: event.paging,
        pagingEnum: event.pagingEnum,
        latitude: event.latitude,
        longitude: event.longitude,
      );
      LeLog.bd(this, _onFetched, nightlifePromoPage.toString());
      emit(NightlifePromoSuccess(nightlifePromoPage: nightlifePromoPage));
    } catch (e) {
      LeLog.be(this, _onFetched, e.toString());
      emit(NightlifePromoFailure());
    }
  }
}

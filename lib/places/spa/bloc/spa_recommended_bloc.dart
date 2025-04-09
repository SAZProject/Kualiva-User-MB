import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/_data/enum/paging_enum.dart';
import 'package:kualiva/_data/model/pagination/paging.dart';
import 'package:kualiva/_repository/place/spa/spa_recommended_repository.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/places/spa/model/spa_recommended_page.dart';

part 'spa_recommended_event.dart';
part 'spa_recommended_state.dart';

class SpaRecommendedBloc
    extends Bloc<SpaRecommendedEvent, SpaRecommendedState> {
  final SpaRecommendedRepository _spaRecommendedRepository;
  SpaRecommendedBloc(
    this._spaRecommendedRepository,
  ) : super(SpaRecommendedInitial()) {
    on<SpaRecommendedEvent>((event, emit) {});
    on<SpaRecommendedFetched>(_onFetched);
  }

  void _onFetched(
    SpaRecommendedFetched event,
    Emitter<SpaRecommendedState> emit,
  ) async {
    final spaRecommendedPageOld =
        _spaRecommendedRepository.getRecommendedOld(null);
    emit(SpaRecommendedLoading(spaRecommendedPage: spaRecommendedPageOld));
    try {
      final spaRecommendedPage = await _spaRecommendedRepository.getRecommended(
        paging: event.paging,
        pagingEnum: event.pagingEnum,
        latitude: event.latitude,
        longitude: event.longitude,
      );
      LeLog.bd(this, _onFetched, spaRecommendedPage.toString());
      emit(SpaRecommendedSuccess(spaRecommendedPage: spaRecommendedPage));
    } catch (e) {
      LeLog.be(this, _onFetched, e.toString());
      emit(SpaRecommendedFailure());
    }
  }
}

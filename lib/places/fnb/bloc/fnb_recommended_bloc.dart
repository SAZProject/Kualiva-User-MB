import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:kualiva/_data/enum/paging_enum.dart';
import 'package:kualiva/_data/model/pagination/paging.dart';
import 'package:kualiva/_repository/place/fnb/fnb_recommended_repository.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/places/fnb/model/fnb_recommended_page.dart';

part 'fnb_recommended_event.dart';
part 'fnb_recommended_state.dart';

class FnbRecommendedBloc
    extends Bloc<FnbRecommendedEvent, FnbRecommendedState> {
  final FnbRecommendedRepository _fnbRecommendedRepository;
  FnbRecommendedBloc(
    this._fnbRecommendedRepository,
  ) : super(FnbRecommendedInitial()) {
    on<FnbRecommendedEvent>((event, emit) {});
    on<FnbRecommendedFetched>(_onFetched);
  }

  void _onFetched(
    FnbRecommendedFetched event,
    Emitter<FnbRecommendedState> emit,
  ) async {
    final fnbRecommendedPageOld = _fnbRecommendedRepository.getRecommendedOld();
    emit(FnbRecommendedLoading(fnbRecommendedPage: fnbRecommendedPageOld));
    try {
      final fnbRecommendedPage = await _fnbRecommendedRepository.getRecommended(
        paging: event.paging,
        pagingEnum: event.pagingEnum,
        latitude: event.latitude,
        longitude: event.longitude,
      );
      LeLog.bd(this, _onFetched, fnbRecommendedPage.toString());
      emit(FnbRecommendedSuccess(fnbRecommendedPage: fnbRecommendedPage));
    } catch (e) {
      LeLog.be(this, _onFetched, e.toString());
      emit(FnbRecommendedFailure());
    }
  }
}

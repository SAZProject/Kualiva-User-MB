import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:kualiva/_data/enum/paging_enum.dart';
import 'package:kualiva/_data/model/pagination/paging.dart';
import 'package:kualiva/_repository/place/spa/spa_nearest_repository.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/places/spa/model/spa_nearest_page.dart';

part 'spa_nearest_event.dart';
part 'spa_nearest_state.dart';

class SpaNearestBloc extends Bloc<SpaNearestEvent, SpaNearestState> {
  final SpaNearestRepository _spaNearestRepository;
  SpaNearestBloc(this._spaNearestRepository) : super(SpaNearestInitial()) {
    on<SpaNearestEvent>((event, emit) => {});
    on<SpaNearestFetched>(_onFetched);
  }

  void _onFetched(
    SpaNearestFetched event,
    Emitter<SpaNearestState> emit,
  ) async {
    try {
      final spaNearestPageOld = _spaNearestRepository.getNearestOld(null);
      emit(SpaNearestLoading(spaNearestPage: spaNearestPageOld));

      final spaNearestPage = await _spaNearestRepository.getNearest(
        paging: event.paging,
        pagingEnum: event.pagingEnum,
        latitude: event.latitude,
        longitude: event.longitude,
      );
      LeLog.bd(this, _onFetched, spaNearestPage.toString());
      emit(SpaNearestSuccess(spaNearestPage: spaNearestPage));
    } catch (e) {
      LeLog.be(this, _onFetched, e.toString());
      emit(SpaNearestFailure());
    }
  }
}

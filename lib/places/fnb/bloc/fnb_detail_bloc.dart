import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:like_it/places/fnb/model/fnb_detail_model.dart';
import 'package:like_it/places/fnb/repository/fnb_repository.dart';

part 'fnb_detail_event.dart';
part 'fnb_detail_state.dart';

class FnbDetailBloc extends Bloc<FnbDetailEvent, FnbDetailState> {
  final FnbRepository _fnbRepository;
  FnbDetailBloc(this._fnbRepository) : super(FnbDetailInitial()) {
    on<FnbDetailEvent>((event, emit) => emit(FnbDetailLoading()));
    on<FnbDetailFetched>(_onFetched);
  }

  void _onFetched(
    FnbDetailFetched event,
    Emitter<FnbDetailState> emit,
  ) async {
    try {
      final FnbDetailModel fnbDetail = await _fnbRepository.getMerchantDetail(
        placeId: event.placeId,
      );
      emit(FnbDetailSuccess(fnbDetail: fnbDetail));
    } catch (e) {
      emit(FnbDetailFailure());
    }
  }
}

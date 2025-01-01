import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/review/model/review_place_model.dart';
import 'package:kualiva/review/repository/review_repository.dart';
part 'review_place_read_event.dart';
part 'review_place_read_state.dart';

class ReviewPlaceReadBloc
    extends Bloc<ReviewPlaceReadEvent, ReviewPlaceReadState> {
  final ReviewRepository _reviewRepository;
  ReviewPlaceReadBloc(this._reviewRepository)
      : super(ReviewPlaceReadInitial()) {
    on<ReviewPlaceReadEvent>((event, emit) => emit(ReviewPlaceReadLoading()));
    on<ReviewPlaceReadFetched>(_onFetched);
  }

  void _onFetched(
    ReviewPlaceReadFetched event,
    Emitter<ReviewPlaceReadState> emit,
  ) async {
    try {
      final List<ReviewPlaceModel> reviewsPlace =
          await _reviewRepository.getByPlace(placeId: event.placeId);
      LeLog.bd(this, _onFetched, reviewsPlace.toString());
      emit(ReviewPlaceReadSuccess(reviewsPlace: reviewsPlace));
    } catch (e) {
      LeLog.be(this, _onFetched, e.toString());
      emit(ReviewPlaceReadFailure());
    }
  }
}

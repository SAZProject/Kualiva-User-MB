import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/review/model/review_place_model.dart';
import 'package:kualiva/review/repository/review_repository.dart';
part 'review_place_my_read_event.dart';
part 'review_place_my_read_state.dart';

class ReviewPlaceMyReadBloc
    extends Bloc<ReviewPlaceMyReadEvent, ReviewPlaceMyReadState> {
  final ReviewRepository _reviewRepository;
  ReviewPlaceMyReadBloc(this._reviewRepository)
      : super(ReviewPlaceMyReadInitial()) {
    on<ReviewPlaceMyReadEvent>(
        (event, emit) => emit(ReviewPlaceMyReadLoading()));
    on<ReviewPlaceMyReadFetched>(_onMyReviewFetched);
  }

  void _onMyReviewFetched(
    ReviewPlaceMyReadFetched event,
    Emitter<ReviewPlaceMyReadState> emit,
  ) async {
    try {
      final List<ReviewPlaceModel> reviewsPlace =
          await _reviewRepository.myReviewGetByPlace(placeId: event.placeId);
      LeLog.bd(this, _onMyReviewFetched, reviewsPlace.toString());
      emit(ReviewPlaceMyReadSuccess(reviewsPlace: reviewsPlace));
    } catch (e) {
      LeLog.be(this, _onMyReviewFetched, e.toString());
      emit(ReviewPlaceMyReadFailure());
    }
  }
}

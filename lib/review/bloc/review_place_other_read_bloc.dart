import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/review/enum/review_order_enum.dart';
import 'package:kualiva/review/enum/review_selected_user_enum.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/review/model/review_place_model.dart';
import 'package:kualiva/_repository/review_repository.dart';
part 'review_place_other_read_event.dart';
part 'review_place_other_read_state.dart';

class ReviewPlaceOtherReadBloc
    extends Bloc<ReviewPlaceOtherReadEvent, ReviewPlaceOtherReadState> {
  final ReviewRepository _reviewRepository;
  ReviewPlaceOtherReadBloc(this._reviewRepository)
      : super(ReviewPlaceOtherReadInitial()) {
    on<ReviewPlaceOtherReadEvent>(
        (event, emit) => emit(ReviewPlaceOtherReadLoading()));
    on<ReviewPlaceOtherReadFetched>(_onOtherReviewFetched);
  }

  void _onOtherReviewFetched(
    ReviewPlaceOtherReadFetched event,
    Emitter<ReviewPlaceOtherReadState> emit,
  ) async {
    try {
      final List<ReviewPlaceModel> reviewsPlace =
          await _reviewRepository.otherReviewGetByPlace(
        isRefreshed: event.isRefreshed,
        placeId: event.placeId,
        description: event.description,
        withMedia: event.withMedia,
        rating: event.rating,
        selectedUser: event.selectedUser,
        order: event.order,
      );
      LeLog.bd(this, _onOtherReviewFetched, reviewsPlace.toString());
      emit(ReviewPlaceOtherReadSuccess(reviewsPlace: reviewsPlace));
    } catch (e) {
      LeLog.be(this, _onOtherReviewFetched, e.toString());
      emit(ReviewPlaceOtherReadFailure());
    }
  }
}

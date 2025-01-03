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
    on<ReviewPlaceMyReadFetched>(_onFetched);
    on<ReviewPlaceMyReadRefreshed>(_onRefreshed);
  }

  void _onFetched(
    ReviewPlaceMyReadFetched event,
    Emitter<ReviewPlaceMyReadState> emit,
  ) async {
    try {
      final ReviewPlaceModel reviewPlace =
          await _reviewRepository.myReviewGetByPlace(placeId: event.placeId);
      LeLog.bd(this, _onFetched, reviewPlace.toString());
      emit(ReviewPlaceMyReadSuccess(reviewPlace: reviewPlace));
    } catch (e) {
      LeLog.be(this, _onFetched, e.toString());
      emit(ReviewPlaceMyReadFailure());
    }
  }

  void _onRefreshed(
    ReviewPlaceMyReadRefreshed event,
    Emitter<ReviewPlaceMyReadState> emit,
  ) async {
    try {
      final ReviewPlaceModel reviewPlace =
          await _reviewRepository.myReviewGetByPlace(placeId: event.placeId);
      LeLog.bd(this, _onRefreshed, reviewPlace.toString());
      emit(ReviewPlaceMyReadSuccess(reviewPlace: reviewPlace));
    } catch (e) {
      LeLog.be(this, _onRefreshed, e.toString());
      emit(ReviewPlaceMyReadFailure());
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:kualiva/_repository/review/review_repository.dart';
import 'package:kualiva/common/utility/lelog.dart';

part 'review_like_event.dart';
part 'review_like_state.dart';

class ReviewLikeBloc extends Bloc<ReviewLikeEvent, ReviewLikeState> {
  final ReviewRepository _reviewRepository;
  ReviewLikeBloc(this._reviewRepository) : super(ReviewLikeInitial()) {
    on<ReviewLikeEvent>((event, emit) => emit(ReviewLikeLoading()));
    on<ReviewLikeAdded>(_onAdded);
    on<ReviewLikeRemoved>(_onRemoved);
  }

  void _onAdded(
    ReviewLikeAdded event,
    Emitter<ReviewLikeState> emit,
  ) async {
    try {
      final _ = await _reviewRepository.addLike(reviewId: event.reviewId);
      emit(ReviewLikeSuccess());
    } catch (e) {
      LeLog.be(this, _onAdded, e.toString());
      emit(ReviewLikeFailure());
    }
  }

  void _onRemoved(
    ReviewLikeRemoved event,
    Emitter<ReviewLikeState> emit,
  ) async {
    try {
      final _ = await _reviewRepository.removeLike(reviewId: event.reviewId);
      emit(ReviewLikeSuccess());
    } catch (e) {
      LeLog.be(this, _onAdded, e.toString());
      emit(ReviewLikeFailure());
    }
  }
}

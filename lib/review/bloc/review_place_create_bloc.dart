import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/_data/enum/place_category_enum.dart';
import 'package:kualiva/_repository/review/review_repository.dart';

part 'review_place_create_event.dart';
part 'review_place_create_state.dart';

class ReviewPlaceCreateBloc
    extends Bloc<ReviewPlaceCreateEvent, ReviewPlaceCreateState> {
  final ReviewRepository _reviewRepository;
  ReviewPlaceCreateBloc(this._reviewRepository)
      : super(ReviewPlaceCreateInitial()) {
    on<ReviewPlaceCreateEvent>(
        (event, emit) => emit(ReviewPlaceCreateLoading()));
    on<ReviewPlaceTempCreated>(_onTempCreated);
    on<ReviewPlaceCreatedOrUpdated>(_onCreatedOrUpdated);
  }

  void _onTempCreated(
    ReviewPlaceTempCreated event,
    Emitter<ReviewPlaceCreateState> emit,
  ) {
    _reviewRepository.tempCreateOrUpdate(
      event.placeUniqueId,
      event.placeCategory,
      event.invoice,
      event.invoiceFile,
    );
  }

  void _onCreatedOrUpdated(
    ReviewPlaceCreatedOrUpdated event,
    Emitter<ReviewPlaceCreateState> emit,
  ) async {
    try {
      final placeId = await _reviewRepository.createOrUpdate(
        reviewId: event.reviewId,
        isCreated: event.isCreated,
        description: event.description,
        rating: event.rating,
        photoFiles: event.photoFiles,
      );
      LeLog.bd(this, _onCreatedOrUpdated, "success");
      emit(ReviewPlaceCreateSuccess(placeId: placeId));
    } catch (e) {
      LeLog.be(this, _onCreatedOrUpdated, e.toString());
      emit(ReviewPlaceCreateFailure());
    }
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/review/model/review_place_model.dart';
import 'package:kualiva/review/repository/review_repository.dart';

part 'review_place_create_event.dart';
part 'review_place_create_state.dart';

class ReviewPlaceCreateBloc
    extends Bloc<ReviewPlaceCreateEvent, ReviewPlaceCreateState> {
  final ReviewRepository _reviewRepository;
  ReviewPlaceCreateBloc(this._reviewRepository)
      : super(ReviewPlaceCreateInitial()) {
    on<ReviewPlaceCreateEvent>(
        (event, emit) => emit(ReviewPlaceCreateLoading()));
    on<ReviewPlaceCreateStarted>(_onStarted);
    on<ReviewPlaceCreate>(_onCreated);
  }

  void _onStarted(
    ReviewPlaceCreateStarted event,
    Emitter<ReviewPlaceCreateState> emit,
  ) {
    LeLog.bd(this, _onStarted, 'On Started');
    emit(ReviewPlaceCreateInitial());
  }

  void _onCreated(
    ReviewPlaceCreate event,
    Emitter<ReviewPlaceCreateState> emit,
  ) async {
    try {
      final _ = await _reviewRepository.create(
        placeId: event.placeId,
        placeCategory: event.placeCategory,
        invoice: event.invoice,
        description: event.description,
        invoiceFile: event.invoiceFile,
        rating: event.rating,
        photoFiles: event.photoFiles,
      );
      LeLog.bd(this, _onCreated, "success");
      emit(ReviewPlaceCreateSuccess());
    } catch (e) {
      LeLog.be(this, _onCreated, e.toString());
      emit(ReviewPlaceCreateFailure());
    }
  }
}

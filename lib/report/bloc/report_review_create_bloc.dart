import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:kualiva/_repository/report_repository.dart';
import 'package:kualiva/common/utility/lelog.dart';

part 'report_review_create_event.dart';
part 'report_review_create_state.dart';

class ReportReviewCreateBloc
    extends Bloc<ReportReviewCreateEvent, ReportReviewCreateState> {
  final ReportRepository _reportRepository;
  ReportReviewCreateBloc(this._reportRepository)
      : super(ReportReviewCreateInitial()) {
    on<ReportReviewCreateEvent>(
        (event, emit) => emit(ReportReviewCreateLoading()));
    on<ReportReviewCreated>(_onCreated);
  }

  void _onCreated(
    ReportReviewCreated event,
    Emitter<ReportReviewCreateState> emit,
  ) async {
    try {
      final point = await _reportRepository.createReviewReport(
        reviewId: event.reviewId,
        reasonId: event.reasonId,
        description: event.description,
      );
      LeLog.bd(this, _onCreated, point.toString());
      emit(ReportReviewCreateSuccess(point: point));
    } catch (e) {
      LeLog.be(this, _onCreated, e.toString());
      emit(ReportReviewCreateFailure());
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:kualiva/_data/model/parameter/parameter_model.dart';
import 'package:kualiva/_repository/common/report_repository.dart';
import 'package:kualiva/common/utility/lelog.dart';

part 'report_review_read_event.dart';
part 'report_review_read_state.dart';

class ReportReviewReadBloc
    extends Bloc<ReportReviewReadEvent, ReportReviewReadState> {
  final ReportRepository _reportRepository;
  ReportReviewReadBloc(this._reportRepository)
      : super(ReportReviewReadInitial()) {
    on<ReportReviewReadEvent>((event, emit) => emit(ReportReviewReadLoading()));
    on<ReportReviewReadFecthed>(_onFetched);
  }

  void _onFetched(
    ReportReviewReadFecthed event,
    Emitter<ReportReviewReadState> emit,
  ) async {
    try {
      final parameter = await _reportRepository.getReviewReasons();
      LeLog.bd(this, _onFetched, parameter.toString());
      emit(ReportReviewReadSuccess(parameter: parameter));
    } catch (e) {
      LeLog.be(this, _onFetched, e.toString());
      emit(ReportReviewReadFailure());
    }
  }
}

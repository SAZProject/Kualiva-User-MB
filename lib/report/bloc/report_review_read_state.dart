part of 'report_review_read_bloc.dart';

@immutable
sealed class ReportReviewReadState {}

final class ReportReviewReadInitial extends ReportReviewReadState {}

final class ReportReviewReadLoading extends ReportReviewReadState {}

final class ReportReviewReadSuccess extends ReportReviewReadState {
  final ParameterModel parameter;

  ReportReviewReadSuccess({required this.parameter});
}

final class ReportReviewReadFailure extends ReportReviewReadState {}

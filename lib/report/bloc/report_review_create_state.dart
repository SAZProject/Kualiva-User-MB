part of 'report_review_create_bloc.dart';

@immutable
sealed class ReportReviewCreateState {}

final class ReportReviewCreateInitial extends ReportReviewCreateState {}

final class ReportReviewCreateLoading extends ReportReviewCreateState {}

final class ReportReviewCreateSuccess extends ReportReviewCreateState {
  final int point;

  ReportReviewCreateSuccess({
    required this.point,
  });
}

final class ReportReviewCreateFailure extends ReportReviewCreateState {}

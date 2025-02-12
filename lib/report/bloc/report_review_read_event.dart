part of 'report_review_read_bloc.dart';

@immutable
sealed class ReportReviewReadEvent {}

final class ReportReviewReadFecthed extends ReportReviewReadEvent {}

final class ReportReviewReadRefreshed extends ReportReviewReadEvent {}

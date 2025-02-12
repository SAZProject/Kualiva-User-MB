part of 'report_review_create_bloc.dart';

@immutable
sealed class ReportReviewCreateEvent {}

final class ReportReviewCreated extends ReportReviewCreateEvent {
  final int reviewId;
  final int reasonId;
  final String description;

  ReportReviewCreated({
    required this.reviewId,
    required this.reasonId,
    required this.description,
  });
}

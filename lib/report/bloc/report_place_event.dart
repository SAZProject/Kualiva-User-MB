part of 'report_place_bloc.dart';

@immutable
sealed class ReportPlaceEvent {}

final class ReportPlaceFetched extends ReportPlaceEvent {}

final class ReportPlaceCreated extends ReportPlaceEvent {
  final String placeId;
  final String reasonCode;
  final int reasonSequence;

  ReportPlaceCreated({
    required this.placeId,
    required this.reasonCode,
    required this.reasonSequence,
  });
}

final class ReportPlaceFileUploaded extends ReportPlaceEvent {
  final String imagePath;

  ReportPlaceFileUploaded({required this.imagePath});
}

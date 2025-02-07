part of 'report_place_bloc.dart';

@immutable
sealed class ReportPlaceEvent {}

final class ReportPlaceFetched extends ReportPlaceEvent {}

final class ReportPlaceCreated extends ReportPlaceEvent {
  final String placeId;
  final int reasonId;

  ReportPlaceCreated({
    required this.placeId,
    required this.reasonId,
  });
}

final class ReportPlaceImageStored extends ReportPlaceEvent {
  final List<String> imagePaths;

  ReportPlaceImageStored({required this.imagePaths});
}

final class ReportPlaceImageDisposed extends ReportPlaceEvent {}

part of 'report_place_bloc.dart';

@immutable
sealed class ReportPlaceState {}

final class ReportPlaceInitial extends ReportPlaceState {}

final class ReportPlaceLoading extends ReportPlaceState {}

final class ReportPlaceFetchSuccess extends ReportPlaceState {
  final ParameterModel parameter;

  ReportPlaceFetchSuccess({required this.parameter});
}

final class ReportPlaceFetchFailure extends ReportPlaceState {}

final class ReportPlaceFileUploadSuccess extends ReportPlaceState {
  final String path;

  ReportPlaceFileUploadSuccess({required this.path});
}

final class ReportPlaceFileUploadFailure extends ReportPlaceState {}

final class ReportPlaceCreatedSuccess extends ReportPlaceState {}

final class ReportPlaceCreatedFailure extends ReportPlaceState {}

part of 'upload_file_bloc.dart';

@immutable
sealed class UploadFileState {}

final class UploadFileInitial extends UploadFileState {
  final List<UploadFileModel> uploadFile;

  UploadFileInitial({this.uploadFile = const []});
}

final class UploadFileLoading extends UploadFileState {}

final class UploadFileSuccess extends UploadFileState {
  final UploadFileModel uploadFile;

  UploadFileSuccess({required this.uploadFile});
}

final class UploadFileFailure extends UploadFileState {}

final class UploadFileRefresh extends UploadFileState {}

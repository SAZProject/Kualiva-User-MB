part of 'upload_file_bloc.dart';

@immutable
sealed class UploadFileEvent {}

final class UploadFileStarted extends UploadFileEvent {}

final class UploadFileCreated extends UploadFileEvent {
  final String imagePath;

  UploadFileCreated({
    required this.imagePath,
  });
}

final class UploadFileRefreshed extends UploadFileEvent {
  final String imagePath;

  UploadFileRefreshed({
    required this.imagePath,
  });
}

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/_data/model/upload_file_model.dart';
import 'package:kualiva/_repository/upload_file_repository.dart';
part 'upload_file_event.dart';
part 'upload_file_state.dart';

class UploadFileBloc extends Bloc<UploadFileEvent, UploadFileState> {
  final UploadFileRepository _uploadFileRepository;
  UploadFileBloc(this._uploadFileRepository) : super(UploadFileInitial()) {
    on<UploadFileEvent>((event, emit) => emit(UploadFileLoading()));
    on<UploadFileStarted>(_onStarted);
    on<UploadFileCreated>(_onCreated);
  }

  void _onStarted(
    UploadFileStarted event,
    Emitter<UploadFileState> emit,
  ) {
    LeLog.bd(this, _onStarted, 'On Started');
    emit(UploadFileInitial());
  }

  void _onCreated(
    UploadFileCreated event,
    Emitter<UploadFileState> emit,
  ) async {
    try {
      final UploadFileModel uploadFile =
          await _uploadFileRepository.uploadFile(imagePath: event.imagePath);
      LeLog.bd(this, _onCreated, uploadFile.toString());
      emit(UploadFileSuccess(uploadFile: uploadFile));
    } catch (e) {
      LeLog.be(this, _onCreated, e.toString());
      emit(UploadFileFailure());
    }
  }
}

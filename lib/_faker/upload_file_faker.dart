import 'package:kualiva/_data/model/upload_file_model.dart';

class UploadFileFaker {
  static UploadFileModel uploadFile() {
    return UploadFileModel(
      imageUrl: 'https://picsum.photos/400/600',
      pathUrl: '',
      message: '',
    );
  }
}

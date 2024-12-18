// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/data/dio_client.dart';
import 'package:kualiva/data/model/upload_file_model.dart';

class UploadFileRepository {
  UploadFileRepository(this._dioClient);

  final DioClient _dioClient;

  Future<UploadFileModel> uploadFile({
    required final String imagePath,
  }) async {
    final String baseUrl = dotenv.get("BASE_URL_MINIO_SERVICE", fallback: null);

    FormData formData = FormData();
    formData.files
        .addAll([MapEntry('image', await MultipartFile.fromFile(imagePath))]);

    final res = await _dioClient.dio().then((dio) {
      dio.options.baseUrl = baseUrl;
      return dio.post(
        "/file-upload/single",
        options: Options(contentType: Headers.multipartFormDataContentType),
      );
    });
    final data = (res.data).map((e) => UploadFileModel.fromMap(e));
    LeLog.rd(this, uploadFile, data.toString());
    return data;
  }

  Future<void> deleteFile({
    required final String imagePath,
  }) async {
    final String baseUrl = dotenv.get("BASE_URL_MINIO_SERVICE", fallback: null);
    final _ = await _dioClient.dio().then((dio) {
      dio.options.baseUrl = baseUrl;
      return dio.post(
        '/file-upload/$imagePath',
      );
    });
    return;
  }
}

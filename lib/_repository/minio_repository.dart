import 'package:dio/dio.dart';
import 'package:kualiva/_data/dio_client_minio.dart';
import 'package:kualiva/_data/model/minio/image_upload_model.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class MinioRepository {
  MinioRepository(this._dioClientMinio);

  final DioClientMinio _dioClientMinio;

  Future<ImageUploadModel> uploadImage({
    required final String imagePath,
  }) async {
    final mimeTypeData =
        lookupMimeType(imagePath, headerBytes: [0xFF, 0xDB])?.split('/');
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        imagePath,
        contentType: MediaType(mimeTypeData![0], mimeTypeData[1]),
      )
    });

    // FormData formData =
    //     FormData.fromMap({"image": MultipartFile.fromFileSync(imagePath)});
    // formData.files
    //     .addAll([MapEntry('image', MultipartFile.fromFileSync(imagePath))]);

    final res = await _dioClientMinio.dio().then((dio) {
      return dio.post(
        "/file-upload/single",
        data: formData,
        options: Options(contentType: Headers.multipartFormDataContentType),
      );
    });
    final data = ImageUploadModel.fromMap(res.data);

    LeLog.rd(this, uploadImage, data.toString());
    return data;
  }

  Future<void> deleteImage({
    required final String fileName,
  }) async {
    await _dioClientMinio.dio().then((dio) {
      return dio.delete('/file-upload/single/$fileName');
    });
    return;
  }

  Future<ImageUploadModel> uploadImages({
    required final List<String> imagePathList,
  }) async {
    final multipartFiles = await Future.wait(imagePathList.map((imagePath) {
      final mimeTypeData =
          lookupMimeType(imagePath, headerBytes: [0xFF, 0xDB])?.split('/');
      return MultipartFile.fromFile(
        imagePath,
        contentType: MediaType(mimeTypeData![0], mimeTypeData[1]),
      );
    }).toList());

    final formData = FormData.fromMap({'images': multipartFiles});

    // FormData formData =
    //     FormData.fromMap({"image": MultipartFile.fromFileSync(imagePath)});
    // formData.files
    //     .addAll([MapEntry('image', MultipartFile.fromFileSync(imagePath))]);

    final res = await _dioClientMinio.dio().then((dio) {
      return dio.post(
        "/file-upload/many",
        data: formData,
        options: Options(contentType: Headers.multipartFormDataContentType),
      );
    });
    final data = ImageUploadModel.fromMap(res.data);

    LeLog.rd(this, uploadImages, data.toString());
    return data;
  }

  Future<void> deleteImages({
    required final List<String> fileNameList,
  }) async {
    final formData = FormData.fromMap({'images': fileNameList});

    await _dioClientMinio.dio().then((dio) {
      return dio.delete(
        '/file-upload/many',
        data: formData,
      );
    });
    return;
  }
}

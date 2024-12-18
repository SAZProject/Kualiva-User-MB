import 'package:dio/dio.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/data/dio_client.dart';
import 'package:kualiva/data/dio_client_minio.dart';
import 'package:kualiva/report/model/parameter_model.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class ReportRepository {
  ReportRepository(this._dioClient, this._dioClientMinio);

  final DioClient _dioClient;
  final DioClientMinio _dioClientMinio;

  final List<String> _photoFiles = [];

  ParameterModel? parameter;

  Future<ParameterModel> getPlaceReasons() async {
    final res = await _dioClient.dio().then((dio) {
      return dio.get(
        '/parameters/code',
        queryParameters: {
          'bizCode': 'FNB',
          'groupCode': '001',
        },
      );
    });

    final data = ParameterModel.fromMap(res.data);
    parameter = data;
    LeLog.rd(this, getPlaceReasons, data.toString());
    return data;
  }

  Future<void> create({
    required String placeId,
    required String reasonCode,
    required int reasonSequence,
  }) async {
    final _ = await _dioClient.dio().then((dio) {
      return dio.post(
        '/places/report',
        data: {
          'placeUniqueId': placeId,
          'reasonCode': reasonCode,
          'reasonSequence': reasonSequence,
          'photoFiles': _photoFiles,
        },
      );
    });

    _photoFiles.clear();
    return;
  }

  Future<ParameterModel> uploadPhoto({
    required final String imagePath,
  }) async {
    final mimeTypeData =
        lookupMimeType(imagePath, headerBytes: [0xFF, 0xDB])?.split('/');
    var formData = FormData.fromMap({
      'image': [
        await MultipartFile.fromFile(
          imagePath,
          contentType: MediaType(mimeTypeData![0], mimeTypeData[1]),
        )
      ]
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
    final path = res.data['pathUrl'] as String;

    _photoFiles.add(path);

    LeLog.rd(this, uploadPhoto, _photoFiles.toString());
    // return res.data['pathUrl'] as String;
    return parameter!;
  }
}

// I/flutter ( 8968): ╔ Headers
// I/flutter ( 8968): ╟ Accept: application/json
// I/flutter ( 8968): ╟ content-type: application/json
// I/flutter ( 8968): ╟ Authorization:
// I/flutter ( 8968): ║ Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJiMGNmOTkzZi1jNWQyLTRmMGUtOWYyOS02YmFiOTE2
// I/flutter ( 8968): ║ MzEzYTAiLCJ1c2VybmFtZSI6ImxlIiwiaWF0IjoxNzM0NTI1OTczLCJleHAiOjE3MzQ1Mjk1NzN9.kYR5rZHdsJpZcsVCqV_qShC
// I/flutter ( 8968): ║ aQFYuLIsL2U20w7FXcNs
// I/flutter ( 8968): ╟ contentType: application/json
// I/flutter ( 8968): ╟ responseType: ResponseType.json
// I/flutter ( 8968): ╟ followRedirects: true
// I/flutter ( 8968): ╟ connectTimeout: 0:00:10.000000
// I/flutter ( 8968): ╟ receiveTimeout: 0:00:10.000000
// I/flutter ( 8968): ╚════════════════════════════════════════════════════════════════════════════════════════════════════╝
// I/flutter ( 8968): ╔ Body
// I/flutter ( 8968): ╟ placeUniqueId: ChIJ22iVuOP3aS4RrHqQSNjlavw
// I/flutter ( 8968): ╟ reasonCode: FNB001
// I/flutter ( 8968): ╟ reasonSequence: 3
// I/flutter ( 8968): ╟ photoFiles: []
// I/flutter ( 8968): ║ {placeUniqueId: ChIJ22iVuOP3aS4RrHqQSNjlavw, reasonCode: FNB001, reasonSequence: 3, photoFiles: []}
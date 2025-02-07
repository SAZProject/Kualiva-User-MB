import 'package:kualiva/_data/enum/parameter_enum.dart';
import 'package:kualiva/_data/model/minio/image_upload_model.dart';
import 'package:kualiva/_data/model/parameter/parameter_model.dart';
import 'package:kualiva/_repository/minio_repository.dart';
import 'package:kualiva/_repository/parameter_repository.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/_data/dio_client.dart';

class ReportRepository {
  ReportRepository(
    this._dioClient,
    this._parameterRepository,
    this._minioRepository,
  );

  final DioClient _dioClient;
  final ParameterRepository _parameterRepository;
  final MinioRepository _minioRepository;

  List<String> _localImagePaths = [];

  Future<ParameterModel> getPlaceReasons() async {
    final data = _parameterRepository.get(ParameterEnum.placeReport);
    LeLog.rd(this, getPlaceReasons, data.toString());
    return data;
  }

  void imageStore({required List<String> imagePaths}) {
    _localImagePaths = imagePaths;
  }

  void imageDispose() {
    _localImagePaths.clear();
  }

  Future<void> create({required String placeId, required int reasonId}) async {
    final List<String> minioImagePaths = [];

    try {
      final ImageUploadModel imageUpload =
          await _minioRepository.uploadImages(imagePathList: _localImagePaths);

      minioImagePaths
          .addAll(imageUpload.images.map((image) => image.pathUrl).toList());

      final _ = await _dioClient.dio().then((dio) {
        return dio.post(
          '/places/report',
          data: {
            'placeUniqueId': placeId,
            'reasonId': reasonId,
            'photoFiles': minioImagePaths,
          },
        );
      });
    } catch (e) {
      if (minioImagePaths.isNotEmpty) {
        _minioRepository.deleteImages(fileNameList: minioImagePaths);
      }
      rethrow;
    } finally {
      imageDispose();
    }
  }
}

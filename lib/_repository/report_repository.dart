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

  void imageStore({required List<String> imagePaths}) {
    _localImagePaths = imagePaths;
  }

  void imageDispose() {
    _localImagePaths.clear();
  }

  /// Report Place
  List<String> _localImagePaths = [];

  Future<ParameterModel> getPlaceReasons() async {
    final data = _parameterRepository.get(ParameterEnum.placeReport);
    LeLog.rd(this, getPlaceReasons, data.toString());
    return data;
  }

  Future<void> createPlaceReport({
    required String placeId,
    required int reasonId,
  }) async {
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

  Future<ParameterModel> getReviewReasons() async {
    final data = _parameterRepository.get(ParameterEnum.reviewReport);
    LeLog.rd(this, getReviewReasons, data.toString());
    return data;
  }

  Future<int> createReviewReport({
    required int reviewId,
    required int reasonId,
    required String description,
  }) async {
    LeLog.rd(this, createReviewReport, "LeRucco");
    LeLog.rd(this, createReviewReport, reviewId.toString());
    LeLog.rd(this, createReviewReport, reasonId.toString());
    LeLog.rd(this, createReviewReport, description.toString());

    final _ = _dioClient.dio().then((dio) {
      return dio.post(
        '/reviews/report',
        data: {
          'reviewId': reviewId,
          'reasonId': reasonId,
          'description': description,
        },
      );
    });

    // TODO Program Service Masz Zaki, get point on review report
    return 10;
  }
}

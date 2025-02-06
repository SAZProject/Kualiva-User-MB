import 'package:kualiva/_data/dio_client_minio.dart';
import 'package:kualiva/_data/enum/parameter_enum.dart';
import 'package:kualiva/_data/model/parameter/parameter_model.dart';
import 'package:kualiva/_repository/parameter_repository.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/_data/dio_client.dart';
// import 'package:kualiva/_data/dio_client_minio.dart';
// import 'package:mime/mime.dart';
// import 'package:http_parser/http_parser.dart';
//// import 'package:http_parser/http_parser.dart';

class ReportRepository {
  ReportRepository(
    this._dioClient,
    this._dioClientMinio,
    this._parameterRepository,
  );

  final DioClient _dioClient;
  final DioClientMinio _dioClientMinio;
  final ParameterRepository _parameterRepository;

  final List<String> _photoFiles = [];

  Future<ParameterModel> getPlaceReasons() async {
    final data = _parameterRepository.get(ParameterEnum.placeReport);
    LeLog.rd(this, getPlaceReasons, data.toString());
    return data;
  }

  Future<void> create({required String placeId, required int reasonId}) async {
    final _ = await _dioClient.dio().then((dio) {
      return dio.post(
        '/places/report',
        data: {
          'placeUniqueId': placeId,
          'reasonId': reasonId,
          'photoFiles': _photoFiles,
        },
      );
    });

    _photoFiles.clear();
    return;
  }
}

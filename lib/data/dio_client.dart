import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  late final Dio _dio;

  Dio get dio => _dio;

  DioClient() {
    final String baseUrl = dotenv.get("BASE_URL", fallback: "");
    if (baseUrl.isEmpty) {
      throw Exception("Dotenv is not set");
    }
    _dio = Dio(BaseOptions(
      baseUrl: '',
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers: Map.from({
        'Accept': 'application/vnd.api+json',
      }),
    ));

    _dio.interceptors.add(PrettyDioLogger(
      compact: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      maxWidth: 100,
      enabled: kDebugMode,
    ));
  }
}

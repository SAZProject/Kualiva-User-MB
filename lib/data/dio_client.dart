import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:like_it/auth/repository/token_manager.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  DioClient(this._tokenManager);

  Dio? _dio;
  final TokenManager _tokenManager;

  Future<Dio> dio() async {
    if (_dio != null) return _dio!;

    String? token = _tokenManager.accessToken;

    final String baseUrl = dotenv.get("BASE_URL", fallback: null);
    if (baseUrl.isEmpty) {
      throw Exception("Dotenv is not set");
    }
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(seconds: 60),
      receiveTimeout: Duration(seconds: 60),
      headers: Map.from({
        'Accept': 'application/json',
      }),
    ));

    _dio!.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['Authorization'] = 'Bearer ${token ?? ''}';
        return handler.next(options);
      },
      onError: (error, handler) {
        return handler.next(error);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
    ));

    _dio!.interceptors.add(PrettyDioLogger(
      compact: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      maxWidth: 100,
      enabled: kDebugMode,
    ));
    return _dio!;
  }

  void clear() {
    _dio = null;
  }
}

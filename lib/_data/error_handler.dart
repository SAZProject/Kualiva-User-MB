// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

class ErrorHandler {
  late Failure failure;

  ErrorHandler.handle(dynamic e) {
    if (e is Failure) {
      failure = e;
    } else if (e is DioException) {
      failure = _handlerError(e);
    } else {
      failure = Failure(source: DataSourceEnum.unknown);
    }
  }
}

class Failure {
  String? originalMessage;
  DataSourceEnum source;
  Map<String, String>? error;

  Failure({
    this.originalMessage,
    this.error,
    required this.source,
  });

  factory Failure.unknown() {
    return Failure(source: DataSourceEnum.unknown);
  }

  @override
  String toString() {
    return 'Failure(source: ${source.name}, source.code: ${source.code}, source.message: ${source.message}, originalMessage: $originalMessage, errors: ${error.toString()})';
  }
}

Failure _handlerError(DioException error) {
  if (error.response?.statusCode == 401) {
    return Failure(
      source: DataSourceEnum.unauthorized,
      originalMessage: error.message,
    );
  }

  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return Failure(
        source: DataSourceEnum.connectionTimeout,
        originalMessage: error.message,
      );
    case DioExceptionType.sendTimeout:
      return Failure(
        source: DataSourceEnum.sendTimeout,
        originalMessage: error.message,
      );
    case DioExceptionType.receiveTimeout:
      return Failure(
        source: DataSourceEnum.receiveTimeout,
        originalMessage: error.message,
      );
    case DioExceptionType.badCertificate:
      return Failure(
        source: DataSourceEnum.badCertificate,
        originalMessage: error.message,
      );
    // case DioExceptionType.badResponse:
    //   return Failure(
    //     source: DataSourceEnum.badResponse,
    //     originalMessage: error.message,
    //   );
    case DioExceptionType.cancel:
      return Failure(
        source: DataSourceEnum.cancel,
        originalMessage: error.message,
      );
    case DioExceptionType.connectionError:
      return Failure(
        source: DataSourceEnum.connectionError,
        originalMessage: error.message,
      );
    default:
  }

  switch (error.response?.statusCode) {
    case 200:
      return Failure(
        source: DataSourceEnum.success,
        originalMessage: error.message,
      );
    case 201:
      return Failure(
        source: DataSourceEnum.created,
        originalMessage: error.message,
      );
    case 400:
      return Failure(
        source: DataSourceEnum.badRequest,
        originalMessage: error.message,
      );
    case 401:
      return Failure(
        source: DataSourceEnum.unauthorized,
        originalMessage: error.message,
      );
    case 403:
      return Failure(
        source: DataSourceEnum.forbidden,
        originalMessage: error.message,
      );
    case 404:
      return Failure(
        source: DataSourceEnum.notFound,
        originalMessage: error.message,
      );
    case 422:
      return Failure(
        source: DataSourceEnum.unprocessableEntity,
        originalMessage: error.response?.data['message'] ?? error.message,
        error: Map.from(error.response?.data['error']),
      );
    case 500:
      return Failure(
        source: DataSourceEnum.internalServerError,
        originalMessage: error.message,
      );
    default:
  }

  return Failure(
    source: DataSourceEnum.unknown,
    originalMessage: error.message,
  );
}

enum DataSourceEnum {
  success(200, 'success'), // 200
  created(201, 'created'), // 201
  badRequest(400, 'badRequest'), // 400
  unauthorized(401, 'unauthorized'), // 401
  forbidden(403, 'forbidden'), // 403
  notFound(404, 'notFound'), // 404
  unprocessableEntity(422, 'unprocessableEntity'),
  internalServerError(500, 'internalServerError'), // 500

  connectionTimeout(-1, 'connectionTimeout'),
  sendTimeout(-2, 'sendTimeout'),
  receiveTimeout(-3, 'receiveTimeout'),
  badCertificate(-4, 'badCertificate'),
  badResponse(-5, 'badResponse'),
  cancel(-6, 'cancel'),
  connectionError(-7, 'connectionError'),
  unknown(0, 'unknown'); // Default

  const DataSourceEnum(this.code, this.message);
  final int code;
  final String message;
}

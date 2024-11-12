import 'package:dio/dio.dart';
import 'package:like_it/data/dio_client.dart';

class ReviewRepository {
  ReviewRepository(this._dioClient);

  final DioClient _dioClient;

  /// Add Reviews by Place
  Future<void> create({
    required String placeId,
    required String transactionNumber,
    required int rating,
    required String description,
    required List<String> invoiceMedia,
  }) async {
    FormData formData = FormData.fromMap({
      /// TODO Here
    });

    formData.files.addAll(await Future.wait(invoiceMedia.map((file) async {
      return MapEntry('media[]', await MultipartFile.fromFile(file));
    })));

    final res = await _dioClient.dio().then((dio) {
      return dio.post(
        'review/place',
        queryParameters: Map.from({
          'place-id': placeId,
        }),
        data: formData,
        options: Options(contentType: Headers.multipartFormDataContentType),
      );
    });

    return;
  }

  /// Reviews by Place
  Future<void> getByPlace({
    required String placeId,
    required bool isFromUser,
    required bool isLatest,
    required bool withPhoto,
    required bool isHighest,
    required int rating,
  }) async {
    final res = await _dioClient.dio().then((dio) {
      return dio.get(
        '/review/place',
        queryParameters: Map.from(
          {
            'place-id': placeId,
          },
        ),
      );
    });
    return;
  }

  /// Review Place Search Text
  Future<void> getBySearchText({required String text}) async {
    final res = await _dioClient.dio().then((dio) {
      return dio.get(
        '/',
        queryParameters: Map.from(
          {'text': text},
        ),
      );
    });
    return;
  }
}
/// 3000 auth
/// 3001 places
/// 3002 review
/// abc1230 
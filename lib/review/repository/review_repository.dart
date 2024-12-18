import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:like_it/common/utility/lelog.dart';
import 'package:like_it/data/dio_client.dart';
import 'package:like_it/main_hive.dart';
import 'package:like_it/review/model/review_place_model.dart';

// AuthorId
// cm3d0h52q0000qtfl1aoq65b8

class ReviewRepository {
  ReviewRepository(this._dioClient);

  final DioClient _dioClient;

  /// Add Reviews by Place
  Future<void> create({
    required String placeId,
    // required String transactionNumber,
    // required int rating,
    // required String description,
    // required List<String> invoiceMedia,
  }) async {
    // FormData formData = FormData.fromMap({
    //   /// TODO Here
    // });

    // formData.files.addAll(await Future.wait(invoiceMedia.map((file) async {
    //   return MapEntry('media[]', await MultipartFile.fromFile(file));
    // })));

    final _ = await _dioClient.dio().then((dio) {
      return dio.post(
        'review/place',

        // queryParameters: Map.from({
        //   'place-id': placeId,
        // }),
        // data: formData,
        options: Options(contentType: Headers.multipartFormDataContentType),
      );
    });

    return;
  }

  /// Reviews by Place / Merchant
  Future<List<ReviewPlaceModel>> getByPlace({
    required String placeId,
  }) async {
    final reviewPlaceBox =
        Hive.box<ReviewPlaceModel>(MyHive.reviewPlaceModel.name);

    if (reviewPlaceBox.values.toList().isNotEmpty) {
      final reviewPlaceList = reviewPlaceBox.values.toList();
      LeLog.rd(this, getByPlace, reviewPlaceList.toString());
      return reviewPlaceList;
    }

    final res = await _dioClient.dio().then((dio) {
      return dio.get('http://192.168.1.89:3000/api/v1/reviews/$placeId/place');
    });

    final data = (res.data as List<dynamic>)
        .map((e) => ReviewPlaceModel.fromMap(e))
        .toList();
    reviewPlaceBox.addAll(data);
    LeLog.rd(this, getByPlace, data.toString());
    return data;
  }

  /// Review Place Search Text
  Future<void> getBySearchText({required String text}) async {
    final _ = await _dioClient.dio().then((dio) {
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
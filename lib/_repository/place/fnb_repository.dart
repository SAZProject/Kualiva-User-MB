import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:kualiva/_data/enum/paging_enum.dart';
import 'package:kualiva/_data/enum/place_category_enum.dart';
import 'package:kualiva/_data/error_handler.dart';
import 'package:kualiva/_data/model/pagination/pagination.dart';
import 'package:kualiva/_data/model/pagination/paging.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/_data/dio_client.dart';
import 'package:kualiva/main_hive.dart';
import 'package:kualiva/places/fnb/model/fnb_detail_model.dart';
import 'package:kualiva/places/fnb/model/fnb_nearest_model.dart';
import 'package:kualiva/places/fnb/model/fnb_nearest_page.dart';
import 'package:kualiva/places/fnb/model/fnb_promo_model.dart';

class FnbRepository {
  FnbRepository(this._dioClient);

  final DioClient _dioClient;

  void invalidate() {}

  Future<FnbNearestPage> getPlacesNearest({
    required Paging paging,
    required PagingEnum pagingEnum,
    required double latitude,
    required double longitude,
  }) async {
    final boxName = MyBox.fnbNearestPage.name;
    final fnbNearestBox = Hive.box<FnbNearestPage>(boxName);

    final oldPage = fnbNearestBox.get(boxName);

    if ((pagingEnum == PagingEnum.before || pagingEnum == PagingEnum.started) &&
        oldPage != null) {
      return oldPage;
    }

    final res = await _dioClient.dio().then((dio) {
      return dio.get(
        '/places/nearest',
        queryParameters: {
          'latitude': latitude,
          'longitude': longitude,
          'type': PlaceCategoryEnum.fnb.name,
        },
      );
    });
    final page = FnbNearestPage(
      data: (res.data['data'] as List<dynamic>)
          .map((e) => FnbNearestModel.fromMap(e))
          .toList(),
      pagination: Pagination.fromMap(res.data['pagination']),
    );

    if (pagingEnum == PagingEnum.paged) {
      final List<FnbNearestModel> temp = [
        ...(oldPage?.data ?? []),
        ...page.data
      ];
      page.data.clear();
      page.data.addAll(temp);
    }

    await fnbNearestBox.delete(boxName);
    await fnbNearestBox.put(boxName, page);

    LeLog.rd(this, getPlacesNearest, page.toString());
    return page;
  }

  Future<FnbDetailModel> getPlaceDetail({
    required String placeId,
  }) async {
    final res = await _dioClient.dio().then((dio) {
      return dio.get(
        '/places/byPlaceId',
        queryParameters: {'placeUniqueId': placeId},
      );
    });
    final data = FnbDetailModel.fromMap(res.data['data']);
    LeLog.rd(this, getPlaceDetail, data.toString());
    return data;
  }

  Future<List<FnbPromoModel>> getPromos({
    required PlaceCategoryEnum placeCategoryEnum,
  }) async {
    try {
      final res = await _dioClient.dio().then((dio) {
        return dio.get('/places/promo',
            queryParameters: {'type': placeCategoryEnum.name});
      });
      final data = (res.data['data'] as List<dynamic>)
          .map((e) => FnbPromoModel.fromMap(e))
          .toList();
      LeLog.rd(this, getPromos, data.toString());
      return data;
    } on DioException catch (e) {
      final failure = ErrorHandler.handle(e).failure;
      LeLog.re(this, getPromos, failure.toString());
      throw failure;
    }
  }
}

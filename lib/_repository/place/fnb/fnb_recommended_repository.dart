import 'package:hive/hive.dart';
import 'package:kualiva/_data/dio_client.dart';
import 'package:kualiva/_data/enum/paging_enum.dart';
import 'package:kualiva/_data/enum/place_category_enum.dart';
import 'package:kualiva/_data/model/pagination/pagination.dart';
import 'package:kualiva/_data/model/pagination/paging.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/main_hive.dart';
import 'package:kualiva/places/fnb/model/fnb_recommended_model.dart';
import 'package:kualiva/places/fnb/model/fnb_recommended_page.dart';

class FnbRecommendedRepository {
  FnbRecommendedRepository(this._dioClient);

  final DioClient _dioClient;

  FnbRecommendedPage? getRecommendedOld(String? name) {
    String boxName = MyBox.fnbRecommendedPage.name;

    if (name != null) {
      boxName = MyBox.fnbRecommendedPage.name;
    }
    final fnbRecommendedBox = Hive.box<FnbRecommendedPage>(boxName);
    return fnbRecommendedBox.get(boxName);
  }

  Future<FnbRecommendedPage> getRecommended({
    String? name,
    required Paging paging,
    required PagingEnum pagingEnum,
    required double latitude,
    required double longitude,
  }) async {
    String boxName = MyBox.fnbRecommendedPage.name;

    if (name != null) boxName = MyBox.fnbRecommendedPage.name;

    final fnbRecommendedBox = Hive.box<FnbRecommendedPage>(boxName);

    final oldPage = fnbRecommendedBox.get(boxName);

    if ((pagingEnum == PagingEnum.before || pagingEnum == PagingEnum.started) &&
        oldPage != null) {
      return oldPage;
    }

    final res = await _dioClient.dio().then((dio) {
      return dio.get(
        '/places/recommended',
        queryParameters: {
          ...paging.toMap(),
          'latitude': latitude,
          'longitude': longitude,
          'type': PlaceCategoryEnum.fnb.name,
          'name': name
        },
      );
    });
    final page = FnbRecommendedPage(
      data: (res.data['data'] as List<dynamic>)
          .map((e) => FnbRecommendedModel.fromMap(e))
          .toList(),
      pagination: Pagination.fromMap(res.data['pagination']),
    );

    if (pagingEnum == PagingEnum.paged) {
      final List<FnbRecommendedModel> tempList = [
        ...(oldPage?.data ?? []),
        ...page.data
      ];
      page.data.clear();
      page.data.addAll(tempList);
    }

    await fnbRecommendedBox.delete(boxName);
    await fnbRecommendedBox.put(boxName, page);

    LeLog.rd(this, getRecommended, page.toString());
    return page;
  }
}

import 'package:hive/hive.dart';
import 'package:kualiva/_data/dio_client.dart';
import 'package:kualiva/_data/enum/paging_enum.dart';
import 'package:kualiva/_data/enum/place_category_enum.dart';
import 'package:kualiva/_data/model/pagination/pagination.dart';
import 'package:kualiva/_data/model/pagination/paging.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/main_hive.dart';
import 'package:kualiva/places/spa/model/spa_recommended_model.dart';
import 'package:kualiva/places/spa/model/spa_recommended_page.dart';

class SpaRecommendedRepository {
  SpaRecommendedRepository(this._dioClient);

  final DioClient _dioClient;

  SpaRecommendedPage? getRecommendedOld() {
    final boxName = MyBox.spaRecommendedPage.name;
    final spaRecommendedBox = Hive.box<SpaRecommendedPage>(boxName);
    return spaRecommendedBox.get(boxName);
  }

  Future<SpaRecommendedPage> getRecommended({
    required Paging paging,
    required PagingEnum pagingEnum,
    required double latitude,
    required double longitude,
  }) async {
    final boxName = MyBox.spaRecommendedPage.name;
    final spaRecommendedBox = Hive.box<SpaRecommendedPage>(boxName);

    final oldPage = spaRecommendedBox.get(boxName);

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
          'type': PlaceCategoryEnum.spa.name,
        },
      );
    });
    final page = SpaRecommendedPage(
      data: (res.data['data'] as List<dynamic>)
          .map((e) => SpaRecommendedModel.fromMap(e))
          .toList(),
      pagination: Pagination.fromMap(res.data['pagination']),
    );

    if (pagingEnum == PagingEnum.paged) {
      final List<SpaRecommendedModel> tempList = [
        ...(oldPage?.data ?? []),
        ...page.data
      ];
      page.data.clear();
      page.data.addAll(tempList);
    }

    await spaRecommendedBox.delete(boxName);
    await spaRecommendedBox.put(boxName, page);

    LeLog.rd(this, getRecommended, page.toString());
    return page;
  }
}

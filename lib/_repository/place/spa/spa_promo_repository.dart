import 'package:hive/hive.dart';
import 'package:kualiva/_data/dio_client.dart';
import 'package:kualiva/_data/enum/paging_enum.dart';
import 'package:kualiva/_data/enum/place_category_enum.dart';
import 'package:kualiva/_data/model/pagination/pagination.dart';
import 'package:kualiva/_data/model/pagination/paging.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/main_hive.dart';
import 'package:kualiva/places/spa/model/spa_promo_model.dart';
import 'package:kualiva/places/spa/model/spa_promo_page.dart';

class SpaPromoRepository {
  SpaPromoRepository(this._dioClient);

  final DioClient _dioClient;

  SpaPromoPage? getPromoOld() {
    final boxName = MyBox.spaPromoPage.name;
    final spaPromoBox = Hive.box<SpaPromoPage>(boxName);
    return spaPromoBox.get(boxName);
  }

  Future<SpaPromoPage> getPromo({
    required Paging paging,
    required PagingEnum pagingEnum,
    required double latitude,
    required double longitude,
  }) async {
    final boxName = MyBox.spaPromoPage.name;
    final spaPromoBox = Hive.box<SpaPromoPage>(boxName);

    final oldPage = spaPromoBox.get(boxName);

    if ((pagingEnum == PagingEnum.before || pagingEnum == PagingEnum.started) &&
        oldPage != null) {
      return oldPage;
    }

    final res = await _dioClient.dio().then((dio) {
      return dio.get(
        '/places/promo',
        queryParameters: {
          ...paging.toMap(),
          'latitude': latitude,
          'longitude': longitude,
          'type': PlaceCategoryEnum.spa.name,
        },
      );
    });

    final page = SpaPromoPage(
      data: (res.data['data'] as List<dynamic>)
          .map((e) => SpaPromoModel.fromMap(e))
          .toList(),
      pagination: Pagination.fromMap(res.data['pagination']),
    );

    if (pagingEnum == PagingEnum.paged) {
      final List<SpaPromoModel> tempList = [
        ...(oldPage?.data ?? []),
        ...page.data
      ];
      page.data.clear();
      page.data.addAll(tempList);
    }

    await spaPromoBox.delete(boxName);
    await spaPromoBox.put(boxName, page);

    LeLog.rd(this, getPromo, page.toString());
    return page;
  }
}

import 'package:hive/hive.dart';
import 'package:kualiva/_data/dio_client.dart';
import 'package:kualiva/_data/enum/paging_enum.dart';
import 'package:kualiva/_data/enum/place_category_enum.dart';
import 'package:kualiva/_data/model/pagination/pagination.dart';
import 'package:kualiva/_data/model/pagination/paging.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/main_hive.dart';
import 'package:kualiva/places/nightlife/model/nightlife_promo_model.dart';
import 'package:kualiva/places/nightlife/model/nightlife_promo_page.dart';

class NightlifePromoRepository {
  NightlifePromoRepository(this._dioClient);

  final DioClient _dioClient;

  NightlifePromoPage? getPromoOld(String? name) {
    String boxName = MyBox.nightlifePromoPage.name;
    if (name != null) boxName = MyBox.nightlifePromoPage.name;

    final nightlifePromoBox = Hive.box<NightlifePromoPage>(boxName);
    return nightlifePromoBox.get(boxName);
  }

  Future<NightlifePromoPage> getPromo({
    required Paging paging,
    required PagingEnum pagingEnum,
    required double latitude,
    required double longitude,
    String? name,
  }) async {
    String boxName = MyBox.nightlifePromoPage.name;
    if (name != null) boxName = MyBox.nightlifePromoPage.name;

    final nightlifePromoBox = Hive.box<NightlifePromoPage>(boxName);

    final oldPage = nightlifePromoBox.get(boxName);

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
          'type': PlaceCategoryEnum.nightLife.name,
          'name': name
        },
      );
    });

    final page = NightlifePromoPage(
      data: (res.data['data'] as List<dynamic>)
          .map((e) => NightlifePromoModel.fromMap(e))
          .toList(),
      pagination: Pagination.fromMap(res.data['pagination']),
    );

    if (pagingEnum == PagingEnum.paged) {
      final List<NightlifePromoModel> tempList = [
        ...(oldPage?.data ?? []),
        ...page.data
      ];
      page.data.clear();
      page.data.addAll(tempList);
    }

    await nightlifePromoBox.delete(boxName);
    await nightlifePromoBox.put(boxName, page);

    LeLog.rd(this, getPromo, page.toString());
    return page;
  }
}

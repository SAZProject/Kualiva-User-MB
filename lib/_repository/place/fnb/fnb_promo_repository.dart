import 'package:hive/hive.dart';
import 'package:kualiva/_data/dio_client.dart';
import 'package:kualiva/_data/enum/paging_enum.dart';
import 'package:kualiva/_data/enum/place_category_enum.dart';
import 'package:kualiva/_data/model/pagination/pagination.dart';
import 'package:kualiva/_data/model/pagination/paging.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/main_hive.dart';
import 'package:kualiva/places/fnb/model/fnb_promo_model.dart';
import 'package:kualiva/places/fnb/model/fnb_promo_page.dart';

class FnbPromoRepository {
  FnbPromoRepository(this._dioClient);

  final DioClient _dioClient;

  FnbPromoPage? getPromoOld(String? name) {
    String boxName = MyBox.fnbPromoPage.name;
    if (name != null) boxName = MyBox.fnbPromoSearchPage.name;

    final fnbPromoBox = Hive.box<FnbPromoPage>(boxName);
    return fnbPromoBox.get(boxName);
  }

  Future<FnbPromoPage> getPromo({
    required Paging paging,
    required PagingEnum pagingEnum,
    required double latitude,
    required double longitude,
    String? name,
  }) async {
    String boxName = MyBox.fnbPromoPage.name;
    if (name != null) boxName = MyBox.fnbPromoSearchPage.name;

    final fnbPromoBox = Hive.box<FnbPromoPage>(boxName);

    final oldPage = fnbPromoBox.get(boxName);

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
          'type': PlaceCategoryEnum.fnb.name,
          'name': name
        },
      );
    });

    final page = FnbPromoPage(
      data: (res.data['data'] as List<dynamic>)
          .map((e) => FnbPromoModel.fromMap(e))
          .toList(),
      pagination: Pagination.fromMap(res.data['pagination']),
    );

    if (pagingEnum == PagingEnum.paged) {
      final List<FnbPromoModel> tempList = [
        ...(oldPage?.data ?? []),
        ...page.data
      ];
      page.data.clear();
      page.data.addAll(tempList);
    }

    await fnbPromoBox.delete(boxName);
    await fnbPromoBox.put(boxName, page);

    LeLog.rd(this, getPromo, page.toString());
    return page;
  }
}

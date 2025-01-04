import 'package:kualiva/_data/enum/place_category_enum.dart';

class FnbDetailScreenArgument {
  final String placeUniqueId;
  final PlaceCategoryEnum placeCategory;

  FnbDetailScreenArgument({
    required this.placeUniqueId,
    required this.placeCategory,
  });
}

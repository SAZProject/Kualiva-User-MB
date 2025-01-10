import 'package:flutter/foundation.dart';
import 'package:kualiva/_data/enum/place_category_enum.dart';

@immutable
class ReviewArgument {
  final String placeUniqueId;
  final PlaceCategoryEnum placeCategory;

  const ReviewArgument({
    required this.placeUniqueId,
    required this.placeCategory,
  });
}

import 'package:flutter/foundation.dart';
import 'package:kualiva/_data/enum/place_category_enum.dart';

@immutable
class ReportPlaceArgument {
  final PlaceCategoryEnum placeCategoryEnum;
  final String placeId;

  const ReportPlaceArgument({
    required this.placeCategoryEnum,
    required this.placeId,
  });
}

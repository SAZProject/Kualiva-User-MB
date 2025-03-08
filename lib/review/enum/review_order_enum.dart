import 'package:hive/hive.dart';

part 'review_order_enum.g.dart';

@HiveType(typeId: 12)
enum ReviewOrderEnum {
  @HiveField(0)
  mostLikes("MOST_LIKES"),

  @HiveField(1)
  recent("RECENT");

  final String value;

  const ReviewOrderEnum(this.value);
}

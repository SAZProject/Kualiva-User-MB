import 'package:hive/hive.dart';

part 'review_selected_user_enum.g.dart';

@HiveType(typeId: 11)
enum ReviewSelectedUserEnum {
  @HiveField(0)
  user("USER"),

  @HiveField(1)
  kualiva("KUALIVA");

  final String value;

  const ReviewSelectedUserEnum(this.value);
}

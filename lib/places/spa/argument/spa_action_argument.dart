import 'package:kualiva/_data/enum/spa_action_enum.dart';

class SpaActionArgument {
  final String title;
  final SpaActionEnum spaActionEnum;
  final String? searchName;

  SpaActionArgument({
    required this.title,
    required this.spaActionEnum,
    this.searchName,
  });
}

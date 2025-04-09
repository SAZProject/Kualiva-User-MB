import 'package:kualiva/_data/enum/fnb_action_enum.dart';

class FnbActionArgument {
  final String title;
  final FnbActionEnum fnbActionEnum;
  final String? searchName;

  FnbActionArgument({
    required this.title,
    required this.fnbActionEnum,
    this.searchName,
  });
}

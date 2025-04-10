import 'package:kualiva/_data/enum/nightlife_action_enum.dart';

class NightlifeActionArgument {
  final String title;
  final NightlifeActionEnum nightlifeActionEnum;
  final String? searchName;

  NightlifeActionArgument({
    required this.title,
    required this.nightlifeActionEnum,
    this.searchName,
  });
}

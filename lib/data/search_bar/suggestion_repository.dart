import 'package:like_it/common/utility/lelog.dart';

class SuggestionRepository {
  final List<String> _homeSuggestionDummy = [
    "Hari Kemerdekaan",
    'Table 8',
    'Starkbuck',
    "Kopi Kenangan",
    "Letto 12",
  ];

  final List<String> _fnbSuggestionDummy = [
    "Makan Nasi",
    "KFC",
    "Lemper",
    "Mie",
    "Jus buah",
  ];
  Future<List<String>> getHomeSuggestion() async {
    final data = _homeSuggestionDummy;

    LeLog.rd(this, getHomeSuggestion, data.toString());
    return data;
  }

  Future<List<String>> getFnbSuggestion() async {
    final data = _fnbSuggestionDummy;

    LeLog.rd(this, getFnbSuggestion, data.toString());
    return data;
  }
}

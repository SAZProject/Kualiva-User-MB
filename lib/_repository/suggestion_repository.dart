import 'package:hive/hive.dart';
import 'package:kualiva/_data/enum/suggestion_enum.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/main_hive.dart';

class SuggestionRepository {
  final suggestionBox = Hive.box<List<String>>(MyHive.suggestion.name);

  Future<List<String>> get(SuggestionEnum suggestionEnum) async {
    final List<String>? suggestionList = suggestionBox.get(
      suggestionEnum.name,
      defaultValue: [],
    );

    return suggestionList?.reversed.toList() ?? [];
  }

  Future<List<String>> add(
    SuggestionEnum suggestionEnum,
    String suggestion,
  ) async {
    final suggestionList = await get(suggestionEnum);
    suggestionList.add(suggestion);
    await suggestionBox.put(suggestionEnum.name, suggestionList);
    LeLog.rd(this, add, "${suggestionEnum.name} - $suggestionList");
    return get(suggestionEnum);
  }

  Future<void> delete(SuggestionEnum suggestionEnum) async {
    LeLog.re(this, delete, suggestionEnum.name);
    return suggestionBox.delete(suggestionEnum.name);
  }

  Future<int> deleteAll() async {
    LeLog.re(this, deleteAll, 'Delete All');
    return suggestionBox.clear();
  }
}

// final List<String> _homeSuggestionDummy = [
//   "Hari Kemerdekaan",
//   'Table 8',
//   'Starkbuck',
//   "Kopi Kenangan",
//   "Letto 12",
// ];

// final List<String> _fnbSuggestionDummy = [
//   "Makan Nasi",
//   "KFC",
//   "Lemper",
//   "Mie",
//   "Jus buah",
// ];

// final List<String> _reviewSuggestionDummy = [
//   "Service",
//   "place",
//   "clean",
//   "food",
// ];

// Future<List<String>> getHomeSuggestion() async {
//   final data = _homeSuggestionDummy;

//   LeLog.rd(this, getHomeSuggestion, data.toString());
//   return data;
// }

// Future<List<String>> getFnbSuggestion() async {
//   final data = _fnbSuggestionDummy;

//   LeLog.rd(this, getFnbSuggestion, data.toString());
//   return data;
// }

// Future<List<String>> getReviewSuggestion() async {
//   final suggestionBox = Hive.box<String>(MyHive.suggestion.name);
//   suggestionBox.get("review");
//   final data = _reviewSuggestionDummy;

//   LeLog.rd(this, getReviewSuggestion, data.toString());
//   return data;
// }

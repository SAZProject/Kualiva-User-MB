import 'package:hive/hive.dart';
import 'package:kualiva/_data/enum/suggestion_enum.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/main_hive.dart';

class SuggestionRepository {
  Future<List<String>> get(SuggestionEnum suggestionEnum) async {
    final suggestionBox = Hive.box<List<String>>(MyBox.suggestion.name);
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
    final suggestionBox = Hive.box<List<String>>(MyBox.suggestion.name);
    if (suggestion.isEmpty) return get(suggestionEnum);

    final suggestionList = await get(suggestionEnum);
    suggestionList.add(suggestion);
    final suggestionListUnique = suggestionList.toSet().toList();
    await suggestionBox.put(suggestionEnum.name, suggestionListUnique);
    LeLog.rd(this, add, "${suggestionEnum.name} - $suggestionListUnique");
    return get(suggestionEnum);
  }

  Future<void> delete(SuggestionEnum suggestionEnum) async {
    final suggestionBox = Hive.box<List<String>>(MyBox.suggestion.name);
    LeLog.rd(this, delete, suggestionEnum.name);
    return suggestionBox.delete(suggestionEnum.name);
  }

  Future<int> deleteAll() async {
    LeLog.rd(this, deleteAll, 'Delete All');
    final suggestionBox = Hive.box<List<String>>(MyBox.suggestion.name);
    return suggestionBox.clear();
  }
}

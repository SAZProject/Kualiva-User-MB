import 'package:hive/hive.dart';
import 'package:kualiva/_data/enum/recent_suggestion_enum.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/main_hive.dart';

class RecentSuggestionRepository {
  Future<List<String>> get(RecentSuggestionEnum recentSuggestionEnum) async {
    final suggestionBox = Hive.box<List<String>>(MyHive.recentSuggestion.name);
    final List<String>? suggestionList = suggestionBox.get(
      recentSuggestionEnum.name,
      defaultValue: [],
    );

    return suggestionList?.reversed.toList() ?? [];
  }

  Future<List<String>> add(
    RecentSuggestionEnum recentSuggestionEnum,
    String suggestion,
  ) async {
    final suggestionBox = Hive.box<List<String>>(MyHive.recentSuggestion.name);
    if (suggestion.isEmpty) return get(recentSuggestionEnum);

    final suggestionList = await get(recentSuggestionEnum);
    suggestionList.add(suggestion);
    final suggestionListUnique = suggestionList.toSet().toList();
    await suggestionBox.put(recentSuggestionEnum.name, suggestionListUnique);
    LeLog.rd(this, add, "${recentSuggestionEnum.name} - $suggestionListUnique");
    return get(recentSuggestionEnum);
  }

  Future<void> delete(RecentSuggestionEnum recentSuggestionEnum) async {
    final suggestionBox = Hive.box<List<String>>(MyHive.recentSuggestion.name);
    LeLog.rd(this, delete, recentSuggestionEnum.name);
    return suggestionBox.delete(recentSuggestionEnum.name);
  }

  Future<int> deleteAll() async {
    LeLog.rd(this, deleteAll, 'Delete All');
    final suggestionBox = Hive.box<List<String>>(MyHive.recentSuggestion.name);
    return suggestionBox.clear();
  }
}

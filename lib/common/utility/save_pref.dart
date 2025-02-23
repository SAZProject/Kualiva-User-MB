import 'package:shared_preferences/shared_preferences.dart';

class SavePref {
  SharedPreferences? sharedPreferences;

  void prefInitial() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  void saveTosData() async {
    if (sharedPreferences == null) return;
    await sharedPreferences!.setBool("tos", true);
  }

  bool readTosData() {
    if (sharedPreferences == null) return false;
    return sharedPreferences!.getBool("tos") ?? false;
  }
}

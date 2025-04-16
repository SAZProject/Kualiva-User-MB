import 'package:shared_preferences/shared_preferences.dart';

class SavePref {
  SharedPreferences? sharedPreferences;

  void saveTosData(bool value) async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences == null) return;
    await sharedPreferences!.setBool("tos", value);
  }

  Future<bool> readTosData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences == null) return false;
    return sharedPreferences!.getBool("tos") ?? false;
  }
}

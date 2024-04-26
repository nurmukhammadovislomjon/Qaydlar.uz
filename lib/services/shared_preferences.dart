import 'package:shared_preferences/shared_preferences.dart';

class ThemePrefs {
  static saveTheme(bool isDarkMode) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool("isDarkMode", isDarkMode);
  }
   static Future<bool?> getTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool("isDarkMode");
  }
  static deleteTheme()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove("isDarkMode");
  }
}

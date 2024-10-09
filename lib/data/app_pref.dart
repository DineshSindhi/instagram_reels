import 'package:shared_preferences/shared_preferences.dart';

class AppPrefs{
  SharedPreferences? prefs;

  Future<void>initPrefs() async {
    prefs=await SharedPreferences.getInstance();
  }

  void setTheme(bool value) async {
    await initPrefs();
    prefs!.setBool('theme', value);
  }
  getTheme() async {
    await initPrefs();
    return prefs!.getBool('theme')??true;
  }
}
import 'package:shared_preferences/shared_preferences.dart';

class Prefs{

  Prefs._privateConstructor();
  static final Prefs _prefs = Prefs._privateConstructor();
  factory Prefs() => _prefs;

  // SharedPereferences keys

  static const USER_LOGIN = "USER_LOGIN";
  static const USER_PASSWORD = "USER_PASSWORD";
  static const USER_TOKEN = "USER_TOKEN";

  // final KEYS = {
  // "USER_LOGIN": "USER_LOGIN",
  // "USER_TOKEN": "USER_TOKEN",
  // "USER_PASSWORD": "USER_PASSWORD"
  // };

  static void setPref(String prefKey, String prefValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(prefKey, prefValue);
  }

  static Future<String> getPref(String prefKey) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(prefKey);
  }
}
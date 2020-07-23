import 'package:shared_preferences/shared_preferences.dart';


class Prefs{

  //create singelton class
  Prefs._privateConstructor();
  static final Prefs _prefs = Prefs._privateConstructor();
  factory Prefs() => _prefs;

  // SharedPereferences keys
  static const USER_LOGIN = "USER_LOGIN";
  static const USER_PASSWORD = "USER_PASSWORD";
  static const USER_TOKEN = "USER_TOKEN";


  // set key/value in shared preferences
  static void setPref(String prefKey, String prefValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(prefKey, prefValue);
  }

  // get value in shared preferences
  static Future<String> getPref(String prefKey) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(prefKey);
  }

  // remove key from shared preferences
  static Future<bool> removePref(String prefKey) async {
    final prefs = await SharedPreferences.getInstance(); 
    return await prefs.remove(prefKey);
  }
}
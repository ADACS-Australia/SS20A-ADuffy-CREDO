import 'package:shared_preferences/shared_preferences.dart';


class Prefs {

  // Create singleton class
  Prefs._privateConstructor();
  static final Prefs _prefs = Prefs._privateConstructor();
  factory Prefs() => _prefs;

  // SharedPreferences keys
  static const USER_LOGIN = "USER_LOGIN";
  static const USER_PASSWORD = "USER_PASSWORD";
  static const USER_TOKEN = "USER_TOKEN";

  static const CAMERA_RESOLUTION = "CAMERA_RESOLUTION";
  static const DETECT_ONLY_WHILE_CHARGING = "DETECT_ONLY_WHILE_CHARGING";
  static const AUTO_OFF = 'AUTO_OFF';

  static const USER_DISPLAY_NAME = "DISPLAY_NAME";
  static const USER_EMAIL = "EMAIL";
  static const USER_TEAM = "TEAM";

  // TODO: Can we template these?
  // Set key/value in shared preferences
  static void setPrefBool(String prefKey, bool prefValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(prefKey, prefValue);
  }

  static void setPrefInt(String prefKey, int prefValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(prefKey, prefValue);
  }

  static void setPrefDouble(String prefKey, double prefValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(prefKey, prefValue);
  }

  static void setPrefString(String prefKey, String prefValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(prefKey, prefValue);
  }

  // TODO: Can we template these?
  // Get value in shared preferences
  static Future<bool> getPrefBool(String prefKey, {bool defaultValue = false}) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      return prefs.containsKey(prefKey) ? prefs.getBool(prefKey) : defaultValue;
    } catch (e) {
      print(e);
      removePref(prefKey);
      return defaultValue;
    }
  }

  static Future<int> getPrefInt(String prefKey, {int defaultValue = 0}) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      return prefs.containsKey(prefKey) ? prefs.getInt(prefKey) : defaultValue;
    } catch (e) {
      print(e);
      removePref(prefKey);
      return defaultValue;
    }
  }

  static Future<double> getPrefDouble(String prefKey, {double defaultValue = 0}) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      return prefs.containsKey(prefKey) ? prefs.getDouble(prefKey) : defaultValue;
    } catch (e) {
      print(e);
      removePref(prefKey);
      return defaultValue;
    }
  }

  static Future<String> getPrefString(String prefKey, {String defaultValue = ''}) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      return prefs.containsKey(prefKey)
          ? prefs.getString(prefKey)
          : defaultValue;
    } catch (e) {
      print(e);
      removePref(prefKey);
      return defaultValue;
    }
  }

  // Remove key from shared preferences
  static Future<bool> removePref(String prefKey) async {
    final prefs = await SharedPreferences.getInstance(); 
    return await prefs.remove(prefKey);
  }
}
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static SharedPreferences? _prefs;

  // Call this before using any method
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save a string
  static Future<void> saveString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  // Get a string
  static String? getString(String key) {
    return _prefs?.getString(key);
  }

  // Save a bool
  static Future<void> saveBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  // Get a bool
  static bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  // Save an int
  static Future<void> saveInt(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  // Get an int
  static int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  // Remove a key
  static Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  // Clear all
  static Future<void> clearAll(String s) async {
    await _prefs?.clear();
  }
}

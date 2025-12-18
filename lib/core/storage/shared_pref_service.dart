import 'package:shared_preferences/shared_preferences.dart';
import 'storage_keys.dart';

class SharedPrefService {
  final SharedPreferences _prefs;

  SharedPrefService(this._prefs);

  // ---------- String ----------
  String? getString(StorageKey key) {
    return _prefs.getString(key.value);
  }

  Future<void> setString(StorageKey key, String value) async {
    await _prefs.setString(key.value, value);
  }

  // ---------- Bool ----------
  bool? getBool(StorageKey key) {
    return _prefs.getBool(key.value);
  }

  Future<void> setBool(StorageKey key, bool value) async {
    await _prefs.setBool(key.value, value);
  }

  // ---------- Int ----------
  int? getInt(StorageKey key) {
    return _prefs.getInt(key.value);
  }

  Future<void> setInt(StorageKey key, int value) async {
    await _prefs.setInt(key.value, value);
  }

  // ---------- Double ----------
  double? getDouble(StorageKey key) {
    return _prefs.getDouble(key.value);
  }

  Future<void> setDouble(StorageKey key, double value) async {
    await _prefs.setDouble(key.value, value);
  }

  // ---------- Remove ----------
  Future<void> remove(StorageKey key) async {
    await _prefs.remove(key.value);
  }

  // ---------- Clear All ----------
  Future<void> clear() async {
    await _prefs.clear();
  }
}

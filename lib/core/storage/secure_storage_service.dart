import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'storage_keys.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageService(this._storage);

  // ---------- String ----------
  Future<String?> getString(StorageKey key) async {
    return await _storage.read(key: key.value);
  }

  Future<void> setString(StorageKey key, String value) async {
    await _storage.write(key: key.value, value: value);
  }

  // ---------- Bool ----------
  Future<bool?> getBool(StorageKey key) async {
    String? value = await _storage.read(key: key.value);
    if (value == null) return null;
    return value == 'true';
  }

  Future<void> setBool(StorageKey key, bool value) async {
    await _storage.write(key: key.value, value: value.toString());
  }

  // ---------- Int ----------
  Future<int?> getInt(StorageKey key) async {
    String? value = await _storage.read(key: key.value);
    if (value == null) return null;
    return int.tryParse(value);
  }

  Future<void> setInt(StorageKey key, int value) async {
    await _storage.write(key: key.value, value: value.toString());
  }

  // ---------- Double ----------
  Future<double?> getDouble(StorageKey key) async {
    String? value = await _storage.read(key: key.value);
    if (value == null) return null;
    return double.tryParse(value);
  }

  Future<void> setDouble(StorageKey key, double value) async {
    await _storage.write(key: key.value, value: value.toString());
  }

  // ---------- Remove ----------
  Future<void> remove(StorageKey key) async {
    await _storage.delete(key: key.value);
  }

  // ---------- Clear All ----------
  Future<void> clear() async {
    await _storage.deleteAll();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../storage/secure_storage_service.dart';
import '../storage/storage_keys.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final SecureStorageService storage;

  ThemeCubit({required this.storage}) : super(ThemeMode.system) {
    _loadTheme();
  }

  void _loadTheme() async {
    final isDark = await storage.getBool(StorageKey.darkMode);
    if (isDark != null) {
      emit(isDark ? ThemeMode.dark : ThemeMode.light);
    }
  }

  void toggleTheme() async {
    final newMode = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    emit(newMode);

    // Store in secure storage
    await storage.setBool(StorageKey.darkMode, newMode == ThemeMode.dark);
  }
}

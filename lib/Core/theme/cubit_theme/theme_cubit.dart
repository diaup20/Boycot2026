import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../services/theme_service.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final SecureStorageService _storage;
  ThemeCubit(this._storage) : super(ThemeMode.light) {
    _load();
  }

  Future<void> _load() async {
    final s = await _storage.readThemeMode();
    switch (s) {
      case 'dark':
        emit(ThemeMode.dark);
        break;
      case 'system':
        emit(ThemeMode.system);
        break;
      default:
        emit(ThemeMode.light);
    }
  }

  Future<void> setLight() async {
    emit(ThemeMode.light);
    await _storage.saveThemeMode('light');
  }

  Future<void> setDark() async {
    emit(ThemeMode.dark);
    await _storage.saveThemeMode('dark');
  }

  Future<void> setSystem() async {
    emit(ThemeMode.system);
    await _storage.saveThemeMode('system');
  }

  void toggle() {
    final next = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(next);
    _storage.saveThemeMode(next == ThemeMode.dark ? 'dark' : 'light');
  }
}

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  // مفتاح لتخزين الثيم
  static const _themeKey = 'app_theme_mode';

  // إنستانس ثابت لإعادة الاستخدام
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // كتابة القيمة (light أو dark)
  Future<void> saveThemeMode(String mode) async {
    await _storage.write(key: _themeKey, value: mode);
  }

  // قراءة القيمة (ترجع null إذا لم تُخزن بعد)
  Future<String?> readThemeMode() async {
    return await _storage.read(key: _themeKey);
  }
}

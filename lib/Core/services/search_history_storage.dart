import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SearchHistoryStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  static const _key = 'search_history';

  Future<List<String>> loadHistory() async {
    final raw = await _storage.read(key: _key);
    if (raw == null || raw.isEmpty) return [];
    return raw.split(',').toSet().toList();
  }

  Future<void> saveHistory(List<String> list) async {
    final joined = list.join(',');
    await _storage.write(key: _key, value: joined);
  }

  Future<void> addEntry(String code) async {
    final current = await loadHistory();
    current.remove(code);
    current.insert(0, code);
    if (current.length > 20) current.removeLast(); 
    await saveHistory(current);
  }

  Future<void> clearHistory() async {
    await _storage.delete(key: _key);
  }
}

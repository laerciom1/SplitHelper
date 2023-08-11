import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SafeStorage {
  static FlutterSecureStorage storage = const FlutterSecureStorage();
  static Future<String?> get(String key) async {
    return storage.read(key: key);
  }

  static Future<void> set(String key, String value) async {
    return storage.write(key: key, value: value);
  }

  static Future<void> saveTokens(dynamic tokens) async {
    final map = {
      'token': tokens.token,
      'tokenSecret': tokens.tokenSecret,
    };
    final mapStr = jsonEncode(map);
    return set('splitwise_tokens', mapStr);
  }

  static Future<dynamic> getTokens() async {
    final mapStr = await get('splitwise_tokens');
    if (mapStr == null) return null;
    final map = jsonDecode(mapStr) as Map;
    return {
      'token': map['token'],
      'tokenSecret': map['tokenSecret'],
    };
  }
}

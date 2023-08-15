import 'package:firebase_database/firebase_database.dart';
import 'package:split_helper/core/domain/entities/settings.dart';
import 'package:split_helper/features/auth/domain/config.dart';

class FirebaseRepository {
  final DatabaseReference _realtimeDatabase = FirebaseDatabase.instance.ref();

  FirebaseRepository();

  dynamic getFinalValue(dynamic value) {
    if (value is Map) {
      return getMap(value);
    }
    if (value is List) {
      return value.map((elem) => getFinalValue(elem)).toList();
    }
    return value;
  }

  Map<String, dynamic> getMap(Object snapshotValue) {
    return (snapshotValue as Map<Object?, Object?>).entries.fold(
      {},
      (accu, curr) {
        accu['${curr.key}'] = getFinalValue(curr.value);
        return accu;
      },
    );
  }

  Future<Config> getConfig() async {
    final snapshot = await _realtimeDatabase.child('_splitwiseConfig').get();
    final map = getMap(snapshot.value!);
    return Config.fromJson(map);
  }

  Future<Settings> getSettings({
    required String userId,
  }) async {
    final snapshot = await _realtimeDatabase.child('_settings/$userId').get();
    final map = getMap(snapshot.value!);
    return Settings.fromJson(map);
  }
}

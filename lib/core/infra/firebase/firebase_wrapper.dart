import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:split_helper/core/domain/entities/settings.dart';
import 'package:split_helper/features/auth/domain/config.dart';

class FirebaseWrapper {
  final DatabaseReference _realtimeDatabase = FirebaseDatabase.instance.ref();
  final FirebaseAuth _auth = FirebaseAuth.instanceFor(
    app: Firebase.app(),
    persistence: Persistence.LOCAL,
  );

  FirebaseWrapper();

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

  bool isSignedIn() => _auth.currentUser != null;

  Future<Config> getConfig() async {
    await _auth.signInAnonymously();
    final snapshot = await _realtimeDatabase.child('_splitwiseConfig').get();
    final map = getMap(snapshot.value!);
    return Config.fromJson(map);
  }

  Future<void> start(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        return;
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<Settings> getSettings() async {
    final uid = _auth.currentUser?.uid;
    final snapshot = await _realtimeDatabase.child('_settings/$uid').get();
    final map = getMap(snapshot.value!);
    return Settings.fromJson(map);
  }
}

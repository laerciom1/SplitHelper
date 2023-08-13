import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:split_helper/oldStructureFold/core/models/auth_data.dart';
import 'package:split_helper/oldStructureFold/core/services/auth/auth_service_interface.dart';

const duration = Duration(seconds: 2);

class AuthServiceFirebase implements IAuthService {
  static AuthData? _currentUser;
  static final _userStream = Stream<AuthData?>.multi((controller) async {
    final authChanges = FirebaseAuth.instance.authStateChanges();
    await for (final user in authChanges) {
      _currentUser = user == null ? null : AuthData(email: user.email!);
      controller.add(_currentUser);
    }
  });

  @override
  Stream<AuthData?> get userChanges => _userStream;

  @override
  AuthData? get currentUser => _currentUser;

  @override
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> signIn(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> signUp(String email, String password) async {
    final UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    if (userCredential.user == null) return;
  }
}

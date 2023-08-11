import 'dart:async';

import 'package:split_helper/core/models/auth_data.dart';
import 'package:split_helper/core/services/auth/auth_service_interface.dart';

const duration = Duration(seconds: 2);

class AuthServiceMock implements IAuthService {
  static final Map<String, AuthData> _users = {
    'f.laerciom@gmail.com': AuthData(
      email: 'f.laerciom@gmail.com',
      password: '123456',
    ),
  };
  static AuthData? _currentUser;
  static MultiStreamController<AuthData?>? _controller;
  static final _userStream = Stream<AuthData?>.multi((controller) {
    _controller = controller;
    _updateUser(null);
  });

  @override
  Stream<AuthData?> get userChanges => _userStream;

  @override
  AuthData? get currentUser => _currentUser;

  @override
  Future<void> logout() async {
    return Future.delayed(duration, () {
      _updateUser(null);
    });
  }

  @override
  Future<void> signIn(String email, String password) async {
    return Future.delayed(duration, () {
      _updateUser(_users[email]);
    });
  }

  @override
  Future<void> signUp(String email, String password) async {
    return Future.delayed(duration, () {
      final newUser = AuthData(email: email, password: password);
      _users.putIfAbsent(email, () => newUser);
      _updateUser(newUser);
    });
  }

  static _updateUser(AuthData? user) {
    _currentUser = user;
    _controller?.add(user);
  }
}

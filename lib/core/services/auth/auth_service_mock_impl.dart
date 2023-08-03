import 'dart:async';

import 'package:split_helper/core/models/auth_data.dart';
import 'package:split_helper/core/services/auth/auth_service_interface.dart';

class AuthServiceMock implements IAuthService {
  static final Map<String, AuthData> _users = {
    'f.laerciom@gmail.com': AuthData('f.laerciom@gmail.com', '123456')
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
    _updateUser(null);
  }

  @override
  Future<void> signIn(String email, String password) async {
    _updateUser(_users[email]);
  }

  @override
  Future<void> signUp(String email, String password) async {
    final newUser = AuthData(email, password);
    _users.putIfAbsent(email, () => newUser);
    _updateUser(newUser);
  }

  static _updateUser(AuthData? user) {
    _currentUser = user;
    _controller?.add(user);
  }
}

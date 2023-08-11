import 'package:split_helper/core/models/auth_data.dart';
import 'package:split_helper/core/services/auth/auth_service_firebase_impl.dart';
// import 'package:split_helper/core/services/auth/auth_service_mock_impl.dart';

abstract class IAuthService {
  AuthData? get currentUser;
  Stream<AuthData?> get userChanges;

  Future<void> signUp(String email, String password);
  Future<void> signIn(String email, String password);
  Future<void> logout();

  factory IAuthService() {
    return AuthServiceFirebase();
  }
}

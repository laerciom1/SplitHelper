class AuthData {
  String email = '';
  String? password = '';

  AuthData({required this.email, this.password});
  AuthData.empty() {
    email = '';
    password = '';
  }
}

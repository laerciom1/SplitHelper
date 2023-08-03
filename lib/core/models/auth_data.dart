class AuthData {
  String? email = '';
  String? password = '';

  AuthData(this.email, this.password);
  AuthData.empty() {
    email = '';
    password = '';
  }
}

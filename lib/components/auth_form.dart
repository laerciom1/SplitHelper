import 'package:flutter/material.dart';
import 'package:split_helper/core/models/auth_data.dart';

enum AuthMode { signIn, signUp }

class AuthForm extends StatefulWidget {
  final Function(AuthData, AuthMode) onSubmit;
  const AuthForm({super.key, required this.onSubmit});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  AuthMode _mode = AuthMode.signIn;
  final _formKey = GlobalKey<FormState>();
  final _authData = AuthData('f.laerciom@gmail.com', '123456');

  _toggleAuthMode() {
    setState(() {
      _mode = _mode == AuthMode.signIn ? AuthMode.signUp : AuthMode.signIn;
    });
  }

  _submit() {
    final validInput = _formKey.currentState?.validate() ?? false;
    if (!validInput) return;
    widget.onSubmit(_authData, _mode);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(24),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: Column(
              children: [
                TextFormField(
                  key: const ValueKey('email'),
                  initialValue: 'f.laerciom@gmail.com',
                  onChanged: (email) => _authData.email = email,
                  validator: (email) {
                    final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(email ?? '');
                    if (!emailValid) {
                      return 'Check the e-mail';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                  ),
                ),
                TextFormField(
                  key: const ValueKey('password'),
                  initialValue: '123456',
                  onChanged: (password) => _authData.password = password,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor:
                        Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                  onPressed: _submit,
                  child:
                      Text(_mode == AuthMode.signIn ? 'Entrar' : 'Cadastrar'),
                ),
                TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor:
                          Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                    onPressed: _toggleAuthMode,
                    child: Text(_mode == AuthMode.signIn
                        ? 'Cadastrar nova conta?'
                        : 'Já possui conta?'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

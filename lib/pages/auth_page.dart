import 'package:flutter/material.dart';
import 'package:split_helper/components/auth_form.dart';
import 'package:split_helper/core/models/auth_data.dart';
import 'package:split_helper/core/services/auth/auth_service_interface.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLoading = false;

  _onSubmit(AuthData data, AuthMode mode) async {
    try {
      setState(() => _isLoading = true);
      if (mode == AuthMode.signIn) {
        await IAuthService().signIn(data.email!, data.password!);
      } else {
        await IAuthService().signUp(data.email!, data.password!);
      }
    } catch (err) {
      // TODO
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AuthForm(onSubmit: _onSubmit),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              decoration: const BoxDecoration(color: Colors.black54),
              child: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).indicatorColor,
                ),
              ),
            )
        ],
      ),
    );
  }
}

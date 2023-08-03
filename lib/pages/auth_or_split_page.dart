import 'package:flutter/material.dart';
import 'package:split_helper/core/models/auth_data.dart';
import 'package:split_helper/core/services/auth/auth_service_interface.dart';
import 'package:split_helper/pages/auth_page.dart';
import 'package:split_helper/pages/loading_page.dart';
import 'package:split_helper/pages/split_page.dart';

class AuthOrSplitPage extends StatelessWidget {
  const AuthOrSplitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<AuthData?>(
        stream: IAuthService().userChanges,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          } else {
            return snapshot.hasData ? const SplitPage() : const AuthPage();
          }
        },
      ),
    );
  }
}

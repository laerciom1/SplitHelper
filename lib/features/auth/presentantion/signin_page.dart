import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:split_helper/core/cross/providers.dart';
import 'package:split_helper/core/presentation/routes/app_router.dart';
import 'package:split_helper/core/presentation/widgets/page_wrapper.dart';
import 'package:split_helper/features/auth/cross/providers.dart';

@RoutePage()
class SignInPage extends StatefulHookConsumerWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _SignInPageState();
  }
}

class _SignInPageState extends ConsumerState<SignInPage> {
  void _onSubmit() {
    final key = ref.read(configNotifierProvider.notifier).consumerKey!;
    final secret = ref.read(configNotifierProvider.notifier).consumerSecret!;
    ref.read(authNotifierProvider.notifier).signIn(
      key,
      secret,
      (authUrl) async {
        final completer = Completer<Uri>();
        AutoRouter.of(context).push(
          AuthRoute(
            authUrl: authUrl,
            onRedirect: (redirectUrl) {
              completer.complete(redirectUrl);
            },
          ),
        );
        return completer.future;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      showAppBar: false,
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor:
                          Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                    onPressed: _onSubmit,
                    child: const Text('SignIn with Splitwise'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

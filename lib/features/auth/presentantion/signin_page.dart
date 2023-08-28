import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:split_helper/core/cross/providers.dart';
import 'package:split_helper/core/presentation/routes/app_router.dart';
import 'package:split_helper/core/presentation/widgets/page_wrapper.dart';

@RoutePage()
class SignInPage extends StatefulHookConsumerWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _SignInPageState();
  }
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final pageController = PageController();

  String error = '';

  Future<void> _onStart() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final email = emailController.value.text;
        final password = passwordController.value.text;
        await ref.read(firebaseWrapperProvider).start(email, password);
        pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.linear,
        );
      } catch (e) {
        setState(() {
          error = e.toString();
        });
      }
    }
  }

  Future<void> _onSplitLogin() async {
    try {
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
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      showAppBar: false,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: PageView(
            controller: pageController,
            children: [
              PageOne(
                formKey: _formKey,
                emailController: emailController,
                passwordController: passwordController,
                onStart: _onStart,
              ),
              PageTwo(onSplitLogin: _onSplitLogin),
            ],
          ),
        ),
        bottomNavigationBar: error.isEmpty ? null : Text(error),
      ),
    );
  }
}

class PageOne extends StatelessWidget {
  const PageOne({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.onStart,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Future<void> Function() onStart;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'To begin, choose an e-mail and a password',
          ),
          const SizedBox(
            height: 12,
          ),
          const Text(
            'Record this data, it will be needed to get access to SplitHelper later',
            textAlign: TextAlign.center,
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(hintText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    final email = value ?? '';
                    if (!RegExp(
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
                    ).hasMatch(email)) {
                      return 'E-mail inválido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(hintText: 'Password'),
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: Theme.of(context).textTheme.bodyMedium?.color,
            ),
            onPressed: onStart,
            child: const Text('Begin'),
          ),
        ],
      ),
    );
  }
}

class PageTwo extends StatelessWidget {
  const PageTwo({
    required this.onSplitLogin,
    super.key,
  });

  final Future<void> Function() onSplitLogin;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Now you need to login in Splitwise, to link the accounts',
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 24,
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: Theme.of(context).textTheme.bodyMedium?.color,
            ),
            onPressed: onSplitLogin,
            child: const Text('SignIn in Splitwise'),
          ),
        ],
      ),
    );
  }
}

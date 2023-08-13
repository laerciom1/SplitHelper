import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:split_helper/core/presentation/routes/app_router.dart';
import 'package:split_helper/features/auth/application/auth_notifier.dart';
import 'package:split_helper/features/auth/cross/providers.dart';

final initializationProvider = FutureProvider((ref) async {});

class SplitHelper extends HookConsumerWidget {
  final ThemeData theme;
  final _appRouter = AppRouter();

  SplitHelper({super.key, required this.theme});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.read(authNotifierProvider.notifier);
    ref.listen<AuthState>(authNotifierProvider, (ctx, state) {
      state.maybeMap(
        orElse: () {},
        authenticated: (_) {
          _appRouter.replaceAll([const SplitsRoute()]);
        },
        unauthenticated: (_) {
          _appRouter.replaceAll([const SignInRoute()]);
        },
      );
    });

    return FutureBuilder(
      future: authNotifier.checkAndUpdateStatus(),
      builder: (context, _) => MaterialApp.router(
        theme: theme,
        routerConfig: _appRouter.config(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

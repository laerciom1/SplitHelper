import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:split_helper/core/application/config_notifier.dart';
import 'package:split_helper/core/cross/providers.dart';
import 'package:split_helper/core/presentation/routes/app_router.dart';
import 'package:split_helper/features/auth/application/auth_notifier.dart';

final initializationProvider = FutureProvider((ref) async {});

class SplitHelper extends StatefulHookConsumerWidget {
  const SplitHelper({
    required this.theme,
    super.key,
  });

  final ThemeData theme;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplitHelperState();
}

class _SplitHelperState extends ConsumerState<SplitHelper> {
  final _appRouter = AppRouter();
  bool? authenticated;

  @override
  Widget build(BuildContext context) {
    final authNotifier = ref.read(authNotifierProvider.notifier);
    final configNotifier = ref.read(configNotifierProvider.notifier);
    // TODO Handle getConfig failure (when ConfigState.failure())
    ref.listen<ConfigState>(configNotifierProvider, (_, state) {
      state.whenOrNull(
        initialized: (_) async {
          await authNotifier.checkAndUpdateStatus();
        },
      );
    });
    ref.listen<AuthState>(authNotifierProvider, (_, state) {
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
      future: configNotifier.initializeConfig(),
      builder: (_, __) => MaterialApp.router(
        theme: widget.theme,
        routerConfig: _appRouter.config(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

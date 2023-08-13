import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:split_helper/core/presentation/routes/app_router.dart';
import 'package:split_helper/features/auth/cross/providers.dart';

class PageWrapper extends HookConsumerWidget {
  final Widget child;
  final bool showAppBar;
  final String? appBarTitle;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  const PageWrapper({
    required this.child,
    required this.showAppBar,
    this.appBarTitle,
    this.floatingActionButton,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onLogout() {
      ref.read(authNotifierProvider.notifier).signOut();
    }

    void goToSettings() {
      AutoRouter.of(context).push(const SettingsRoute());
    }

    return SafeArea(
      child: Scaffold(
        appBar: showAppBar
            ? AppBar(
                title: Text(appBarTitle ?? 'Split Helper'),
                centerTitle: true,
                actions: [
                  IconButton(
                    onPressed: goToSettings,
                    icon: const Icon(Icons.settings),
                  ),
                  IconButton(
                    onPressed: onLogout,
                    icon: const Icon(Icons.logout),
                  ),
                ],
              )
            : null,
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: bottomNavigationBar,
        body: child,
      ),
    );
  }
}

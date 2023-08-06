import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';

import 'package:flutter/services.dart';
import 'package:split_helper/config/routes.dart';
import 'dart:convert';

import 'package:split_helper/pages/auth_or_split_page.dart';
import 'package:split_helper/pages/settings_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeStr = await rootBundle.loadString('assets/appainter_theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;

  runApp(MyApp(theme: theme));
}

class MyApp extends StatelessWidget {
  final ThemeData theme;

  const MyApp({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,
      routes: {
        Routes.settings: (_) => const SettingsPage(),
        Routes.splits: (_) => const AuthOrSplitPage(),
      },
    );
  }
}

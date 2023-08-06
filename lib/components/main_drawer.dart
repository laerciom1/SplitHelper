import 'package:flutter/material.dart';
import 'package:split_helper/config/routes.dart';
import 'package:split_helper/core/services/auth/auth_service_interface.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: Text(
              'Split Helper',
            ),
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {
              Navigator.pushNamed(context, Routes.settings);
            },
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () {
              IAuthService().logout();
            },
          ),
        ],
      ),
    );
  }
}
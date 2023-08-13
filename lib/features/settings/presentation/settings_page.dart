import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:split_helper/core/presentation/widgets/page_wrapper.dart';
import 'package:split_helper/oldStructureFold/core/models/settings_data.dart';
import 'package:split_helper/oldStructureFold/core/services/user_preferences/user_preferences_service_interface.dart';

Widget getCategoryCard(Category category) {
  return Card(
    elevation: 4,
    clipBehavior: Clip.hardEdge,
    child: Row(
      children: [
        Image.network(
          category.imageUrl,
          height: 64,
        ),
        Expanded(
          child: Container(
            constraints: const BoxConstraints(maxHeight: 64),
            child: Text(
              category.prefix,
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    ),
  );
}

@RoutePage()
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final GlobalKey<ScaffoldState> _scaffoldKey;
  Settings? _settings;

  bool shareConfigIsOpen = false;
  bool categoriesConfigIsOpen = false;

  @override
  void initState() {
    _scaffoldKey = GlobalKey();
    IUserPreferencesService().get().listen((event) {
      setState(() {
        _settings = event;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _scaffoldKey.currentState?.dispose();
    super.dispose();
  }

  Widget shareConfigCard() {
    Widget body = const Text('Fetching config...');
    if (_settings != null) {
      body = Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Share % Config'),
              Text(
                '${_settings!.shareConfig}/${100 - _settings!.shareConfig!}',
              ),
            ],
          ),
          Slider.adaptive(
            value: _settings!.shareConfig! / 100,
            onChanged: (value) {
              setState(() {
                _settings!.shareConfig = (value * 100).toInt();
              });
            },
          ),
        ],
      );
    }
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16,
          right: 16,
          left: 16,
        ),
        child: body,
      ),
    );
  }

  Widget categoriesConfigCard() {
    Widget body = const Text('Fetching config...');
    if (_settings != null) {
      body = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Categories Config'),
          const SizedBox(height: 12),
          SizedBox(
            height: MediaQuery.of(context).size.height * .58,
            child: GridView.count(
              childAspectRatio: 6 / 2,
              shrinkWrap: true,
              crossAxisCount: 2,
              children: [
                ..._settings!.myCategories!
                    .map((category) => getCategoryCard(category)),
                GestureDetector(
                  onTap: onTapAddCategory,
                  child: const Card(
                    elevation: 4,
                    clipBehavior: Clip.hardEdge,
                    child: Center(child: Text('+')),
                  ),
                )
              ],
            ),
          ),
        ],
      );
    }
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: body,
      ),
      // child: Text('getCategoriesConfigCard'),
    );
  }

  onTapApply() {
    // TODO Apply settings
    Navigator.of(context).pop();
  }

  onTapAddCategory() {
    // TODO Make "Add Category" flow
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      showAppBar: true,
      appBarTitle: 'Settings',
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 128,
          vertical: 8,
        ),
        child: ElevatedButton(
          onPressed: onTapApply,
          child: const Text('Apply'),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            shareConfigCard(),
            categoriesConfigCard(),
          ],
        ),
      ),
    );
  }
}

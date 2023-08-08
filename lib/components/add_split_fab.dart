import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:split_helper/core/models/settings_data.dart';

class AddSplitFAB extends StatelessWidget {
  const AddSplitFAB({
    super.key,
    required this.settings,
    required this.onTapAddSplit,
  });

  final Settings settings;
  final void Function(Category) onTapAddSplit;

  List<SpeedDialChild> getCategoriesDialButtons(context) =>
      settings.myCategories!
          .map(
            (category) => SpeedDialChild(
              backgroundColor: Colors.transparent,
              child: Card(
                elevation: 4,
                clipBehavior: Clip.hardEdge,
                child: Image.network(
                  category.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              labelBackgroundColor: Theme.of(context).primaryColor,
              label: category.prefix,
              labelStyle: const TextStyle(
                fontSize: 12,
              ),
              onTap: () {
                onTapAddSplit(category);
              },
            ),
          )
          .toList();

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      buttonSize: const Size(44, 44),
      childrenButtonSize: const Size(48, 48),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: Theme.of(context).colorScheme.onSurface,
      icon: Icons.add,
      activeIcon: Icons.close,
      children: [
        ...getCategoriesDialButtons(context),
      ],
      childPadding: const EdgeInsets.all(0),
      childMargin: const EdgeInsets.all(4),
      spaceBetweenChildren: 8,
      spacing: 4,
    );
  }
}

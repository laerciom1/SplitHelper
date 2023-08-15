import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:split_helper/core/application/session_notifier.dart';
import 'package:split_helper/core/cross/providers.dart';
import 'package:split_helper/core/domain/entities/category.dart';
import 'package:split_helper/core/domain/entities/settings.dart';
import 'package:split_helper/core/presentation/widgets/page_wrapper.dart';
import 'package:split_helper/features/split_list/application/splits_notifier.dart';
import 'package:split_helper/features/split_list/cross/providers.dart';
import 'package:split_helper/features/split_list/domain/split_data.dart';
import 'package:split_helper/features/split_list/presentation/widgets/add_split_bs.dart';
import 'package:split_helper/features/split_list/presentation/widgets/add_split_fab.dart';
import 'package:split_helper/features/split_list/presentation/widgets/split.dart';

@RoutePage()
class SplitsPage extends StatefulHookConsumerWidget {
  const SplitsPage({super.key});
  @override
  ConsumerState<SplitsPage> createState() => _SplitsPageState();
}

class _SplitsPageState extends ConsumerState<SplitsPage> {
  List<SplitData> _splits = [];
  Settings? _settings;
  int shareConfig = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    ref
        .read(sessionNotifierProvider.notifier)
        .initializeSession()
        .then((state) {
      state.whenOrNull(
        initialized: (currentUserId, currentSetting) {
          ref.read(splitsNotifierProvider.notifier).getSplits(currentSetting);
        },
      );
    });
  }

  Future<void> onAddSplit(
    Category category,
    String description,
    double cost,
    int shareConfig,
  ) async {
    setState(() {
      _isLoading = true;
    });
    // await ISplitsService().save(
    //   category: category,
    //   cost: cost,
    //   description: description,
    //   shareConfig: shareConfig,
    // );
    setState(() {
      _isLoading = false;
    });
  }

  void onSelectCategory(Category category) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return AddSplitBS(
          category: category,
          initialShareConfig: shareConfig,
          onApply: onAddSplit,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final splitsNotifier = ref.watch(splitsNotifierProvider.notifier);
    final sessionState = ref.read(sessionNotifierProvider);
    final currSettings =
        sessionState.whenOrNull(initialized: (_, currSettings) => currSettings);

    return PageWrapper(
        showAppBar: true,
        floatingActionButton: _settings != null
            ? AddSplitFAB(
                settings: _settings!,
                onSelectCategory: onSelectCategory,
              )
            : null,
        child: StreamBuilder(
          stream: splitsNotifier.stream,
          initialData: const SplitsState.loading(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!.when(
                empty: () {
                  return const Text('empty');
                },
                initialized: (splits) {
                  return RefreshIndicator(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: splits.length,
                              itemBuilder: (ctx, i) => Split(
                                key: ValueKey(splits[i].id),
                                split: splits[i],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    onRefresh: () {
                      return splitsNotifier.getSplits(currSettings!);
                    },
                  );
                },
                loading: () {
                  return ColoredBox(
                    color: Colors.black54,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).indicatorColor,
                      ),
                    ),
                  );
                },
              );
            }
            return ColoredBox(
              color: Colors.black54,
              child: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).indicatorColor,
                ),
              ),
            );
          },
        ));
  }
}

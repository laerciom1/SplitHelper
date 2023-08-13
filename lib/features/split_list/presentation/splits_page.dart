import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:split_helper/core/presentation/widgets/page_wrapper.dart';
import 'package:split_helper/features/split_list/presentation/widgets/add_split_bs.dart';
import 'package:split_helper/features/split_list/presentation/widgets/add_split_fab.dart';
import 'package:split_helper/features/split_list/presentation/widgets/split.dart';
import 'package:split_helper/oldStructureFold/core/models/settings_data.dart';
import 'package:split_helper/oldStructureFold/core/models/split_data.dart';
import 'package:split_helper/oldStructureFold/core/services/splits/splits_service_interface.dart';
import 'package:split_helper/oldStructureFold/core/services/user_preferences/user_preferences_service_interface.dart';

@RoutePage()
class SplitsPage extends StatefulWidget {
  const SplitsPage({super.key});
  @override
  State<SplitsPage> createState() => _SplitsPageState();
}

class _SplitsPageState extends State<SplitsPage> {
  late final GlobalKey<ScaffoldState> _scaffoldKey;
  Settings? _settings;
  int shareConfig = 0;
  bool _isLoading = false;

  @override
  void initState() {
    _scaffoldKey = GlobalKey();
    IUserPreferencesService().get().listen((event) {
      setState(() {
        _settings = event;
        if (_settings != null) {
          shareConfig = _settings!.shareConfig!;
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _scaffoldKey.currentState?.dispose();
    super.dispose();
  }

  onAddSplit(
    Category category,
    String description,
    double cost,
    int shareConfig,
  ) async {
    setState(() {
      _isLoading = true;
    });
    await ISplitsService().save(
      category: category,
      cost: cost,
      description: description,
      shareConfig: shareConfig,
    );
    setState(() {
      _isLoading = false;
    });
  }

  onSelectCategory(Category category) {
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
    return PageWrapper(
      showAppBar: true,
      floatingActionButton: _settings != null
          ? AddSplitFAB(
              settings: _settings!,
              onSelectCategory: onSelectCategory,
            )
          : null,
      child: Stack(
        children: [
          RefreshIndicator(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: StreamBuilder<List<SplitData>>(
                      stream: ISplitsService().getSplits(),
                      builder: (ctx, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).indicatorColor,
                            ),
                          );
                        }
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text('Sem dados...'),
                          );
                        }
                        final splits = snapshot.data!;
                        return ListView.builder(
                          itemCount: splits.length,
                          itemBuilder: (ctx, i) => Split(
                            key: ValueKey(splits[i].id),
                            split: splits[i],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            onRefresh: () {
              return ISplitsService().updateSplits();
            },
          ),
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).indicatorColor,
                ),
              ),
            )
        ],
      ),
    );
  }
}

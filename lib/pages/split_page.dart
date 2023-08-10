import 'package:flutter/material.dart';
import 'package:split_helper/components/add_split_bs.dart';
import 'package:split_helper/components/add_split_fab.dart';
import 'package:split_helper/components/main_drawer.dart';
import 'package:split_helper/components/split.dart';
import 'package:split_helper/core/models/settings_data.dart';
import 'package:split_helper/core/models/split_data.dart';
import 'package:split_helper/core/services/settings/settings_service_interface.dart';
import 'package:split_helper/core/services/splits/splits_service_interface.dart';

class SplitPage extends StatefulWidget {
  const SplitPage({super.key});
  @override
  State<SplitPage> createState() => _SplitPageState();
}

class _SplitPageState extends State<SplitPage> {
  late final GlobalKey<ScaffoldState> _scaffoldKey;
  Settings? _settings;
  int shareConfig = 0;
  bool _isLoading = false;

  @override
  void initState() {
    _scaffoldKey = GlobalKey();
    ISettingsService().get().listen((event) {
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
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('Split Helper'),
            centerTitle: true,
          ),
          key: _scaffoldKey,
          drawer: const MainDrawer(),
          floatingActionButton: _settings != null
              ? AddSplitFAB(
                  settings: _settings!,
                  onSelectCategory: onSelectCategory,
                )
              : null,
          body: Stack(
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
            ],
          ),
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:split_helper/components/main_drawer.dart';
import 'package:split_helper/components/split.dart';
import 'package:split_helper/core/models/split_data.dart';
import 'package:split_helper/core/services/splits/splits_service_interface.dart';

class SplitPage extends StatefulWidget {
  const SplitPage({super.key});
  @override
  State<SplitPage> createState() => _SplitPageState();
}

class _SplitPageState extends State<SplitPage> {
  late final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    _scaffoldKey = GlobalKey();
    super.initState();
  }

  @override
  void dispose() {
    _scaffoldKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Split Helper'),
          centerTitle: true,
        ),
        key: _scaffoldKey,
        drawer: const MainDrawer(),
        body: RefreshIndicator(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
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
          ),
          onRefresh: () {
            return ISplitsService().updateSplits();
          },
        ),
      ),
    );
  }
}

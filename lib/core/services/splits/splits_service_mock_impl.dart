import 'dart:math';
import 'dart:async';
import 'package:split_helper/core/models/settings_data.dart';
import 'package:split_helper/core/models/split_data.dart';
import 'package:split_helper/core/services/splits/splits_mock.dart';
import 'package:split_helper/core/services/splits/splits_service_interface.dart';

class SplitsServiceMock implements ISplitsService {
  static List<SplitData> _splits = [...mockedSplitsData];
  static MultiStreamController<List<SplitData>>? _controller;
  static final _splitsStream = Stream<List<SplitData>>.multi((controller) {
    _controller = controller;
    controller.add(_splits);
  });

  @override
  Stream<List<SplitData>> getSplits() {
    return _splitsStream;
  }

  @override
  Future<SplitData> save({
    required double cost,
    required String description,
    required Category category,
    required int groupId,
    required List<UserSplitData> shares,
  }) async {
    final split = SplitData(
      id: Random().nextInt(24),
      description: description,
      cost: cost.toStringAsFixed(2),
      date: DateTime.now().toIso8601String(),
      users: shares,
      category: category,
    );
    _splits.add(split);
    _controller?.add(_splits);
    return split;
  }

  @override
  Future<void> updateSplits() async {
    final splits = [..._splits, _splits[0]];
    splits.removeAt(0);
    _splits = [...splits];
    _controller?.add(splits);
  }
}

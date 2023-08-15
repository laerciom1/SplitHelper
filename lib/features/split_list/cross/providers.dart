import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:split_helper/core/cross/providers.dart';
import 'package:split_helper/features/split_list/application/splits_notifier.dart';

final splitsNotifierProvider =
    StateNotifierProvider<SplitsNotifier, SplitsState>(
  (ref) => SplitsNotifier(ref.watch(splitwiseRepositoryProvider)),
);

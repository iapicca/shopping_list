import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_list/model/all.dart';

/// a `Provider` for a `void Function(FailureReport)`
final onErrorPod = Provider<void Function(FailureReport report)>((ref) {
  return (report) {};
});

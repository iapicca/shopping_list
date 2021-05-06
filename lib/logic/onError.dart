import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_list/logic/snack/on_error.dart';
import 'package:shopping_list/model/all.dart';

/// a `Provider` for a `void Function(FailureReport)`
final onErrorPod = Provider<void Function(FailureReport)>((ref) {
  // ignore: unnecessary_lambdas

  return (report) {
    final callback = ref.read(onErrorSnackCallbackPod).value;
    callback?.call();
  };
});

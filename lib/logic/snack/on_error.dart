import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// a `provider` for `offlineSnack`

final onErrorSnackCallbackPod = Provider<ValueNotifier<VoidCallback?>>((ref) {
  final notifier = ValueNotifier<VoidCallback?>(null);
  return notifier;
});

/// a function that shows a `snackbar` when device experiece an `error`
void errorSnackbar(BuildContext context) async {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      key: const ValueKey('SnackBar@errorSnackbar'),
      duration: const Duration(days: 365),
      content: const Text('an error has occurred'),
      action: SnackBarAction(
        label: 'I see',
        onPressed: () {},
      )));
}

/// expose to ui a one time setter for a callback
final memoizedOnErrorSnackCallbackPod =
    Provider<void Function(BuildContext)>((ref) {
  final setter = ref.read(onErrorSnackCallbackPod);
  return (context) {
    setter.value = () => errorSnackbar(context);
  };
});

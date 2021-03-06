import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// a function that shows a `snackbar` to confirm a delete action
Future<bool> confirmDelete(BuildContext context) async {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  final maybeAction = await ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(
          key: const ValueKey('SnackBar@confirmDelete'),
          duration: const Duration(seconds: 2),
          content: const Text('do you want to delete?'),
          action: SnackBarAction(
            label: 'delete',
            onPressed: () {},
          )))
      .closed;
  return maybeAction == SnackBarClosedReason.action;
}

/// a `provider` for `confirmDelete`
final confirmDeletePod = Provider<Future<bool> Function(BuildContext)>((ref) {
  return confirmDelete;
});

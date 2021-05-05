import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

/// a function that shows a `snackbar` when devide is `offline`
void offlineSnack(BuildContext context) async {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      key: const ValueKey('SnackBar@offlineSnack'),
      duration: const Duration(days: 365),
      content: const Text('You are offline!'),
      action: SnackBarAction(
        label: 'I know',
        onPressed: () {},
      )));
}

/// a function that shows a `snackbar` when devide is `online`
void onlineSnack(BuildContext context, ConnectivityResult result) async {
  final connection = result.toString().split('.').last;
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      key: const ValueKey('SnackBar@onlineSnack'),
      duration: const Duration(seconds: 1),
      content: Text('Connected with $connection!'),
    ),
  );
}

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_list/domain/all.dart';

/// return the a `ValueNotifier<ConnectivityResult>`
final connectivityResultPod =
    Provider<ValueNotifier<ConnectivityResult>>((ref) {
  final notifier = ValueNotifier(ConnectivityResult.wifi);
  ref.read(connectivityPod)..listen((result) => notifier.value = result);
  return notifier;
});

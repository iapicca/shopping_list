import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_list/logic/all.dart';
import 'package:shopping_list/logic/snack/connectivity.dart';

void main() {
  final container = ProviderContainer();

  group('connectivity snack test', () {
    test(
        'WHEN ` container.read(onlineSnackPod)`'
        'THEN returns `void Function(BuildContext, ConnectivityResult)`', () {
      expect(
        container.read(onlineSnackPod),
        isA<void Function(BuildContext, ConnectivityResult)>(),
        reason: 'should return a `ValueNotifier<ConnectivityResult>`',
      );
    });

    test(
        'WHEN ` container.read(offlineSnackPod)`'
        'THEN returns `void Function(BuildContext)`', () {
      expect(
        container.read(offlineSnackPod),
        isA<void Function(BuildContext)>(),
        reason: 'should return a `void Function(BuildContext)`',
      );
    });
  });
}

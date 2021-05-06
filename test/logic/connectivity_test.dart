import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_list/domain/all.dart';
import 'package:shopping_list/logic/all.dart';

void main() {
  final container = ProviderContainer(
    overrides: [
      connectivityPod.overrideWithValue(
        Stream.fromIterable([ConnectivityResult.none]),
      ),
    ],
  );

  group('connectivityResultPod test', () {
    test(
        'WHEN container.read'
        'THEN returns `ValueNotifier<ConnectivityResult>`', () {
      expect(
        container.read(connectivityResultPod),
        isA<ValueNotifier<ConnectivityResult>>(),
        reason: 'should return a `ValueNotifier<ConnectivityResult>`',
      );
    });

    test(
        'GIVEN default value is `ConnectivityResult.wifi`'
        'WHEN `connectivityPod` stream data'
        'THEN `connectivityResultPod` updates its `value`', () async {
      await Future.delayed(const Duration(milliseconds: 50));

      expect(
        container.read(connectivityResultPod).value,
        ConnectivityResult.none,
        reason: 'should return a `ValueNotifier<ConnectivityResult>`',
      );
    });
  });
}

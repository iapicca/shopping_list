import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_list/logic/all.dart';

void main() {
  final container = ProviderContainer();

  group('confirmDeletePod test', () {
    test(
        'WHEN container.read'
        'THEN returns `Future<bool> Function(BuildContext)`', () {
      expect(
        container.read(confirmDeletePod),
        isA<Future<bool> Function(BuildContext)>(),
        reason: 'should return a `Future<bool> Function(BuildContext)`',
      );
    });
  });
}

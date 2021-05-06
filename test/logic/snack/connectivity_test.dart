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
    testWidgets(
        'GIVEN offlineSnack'
        'WHEN `fab` pressed '
        'THEN `edit` should not be called', (tester) async {
      final app = MaterialApp(
        home: Scaffold(
            floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            onPressed: () => offlineSnack(context),
          ),
        )),
      );
      await tester.pumpWidget(app);
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(
        find.byType(SnackBar),
        findsOneWidget,
        reason: 'should find a `SnackBar`',
      );
    });

    testWidgets(
        'GIVEN onlineSnack'
        'WHEN `fab` pressed '
        'THEN `edit` should not be called', (tester) async {
      final app = MaterialApp(
        home: Scaffold(
            floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            onPressed: () => onlineSnack(context, ConnectivityResult.wifi),
          ),
        )),
      );
      await tester.pumpWidget(app);
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(
        find.byType(SnackBar),
        findsOneWidget,
        reason: 'should find a `SnackBar`',
      );
    });
  });
}

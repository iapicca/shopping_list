import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_list/logic/all.dart';
import 'package:shopping_list/logic/snack/confirm_delete.dart';

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

    testWidgets(
        'GIVEN confirmDelete'
        'WHEN `fab` pressed '
        'THEN `edit` should not be called', (tester) async {
      final app = MaterialApp(
        home: Scaffold(
            floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            onPressed: () => confirmDelete(context),
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

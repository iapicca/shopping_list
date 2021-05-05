import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_list/logic/snack/confirm_delete.dart';

void main() {
  group('confirmDelete test', () {
    testWidgets(
        'GIVEN there is no scaffold '
        'WHEN `confirmDelete` is called '
        'THEN should not show', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Material(
              child: FloatingActionButton(
                onPressed: () => confirmDelete(context),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(
        find.byType(SnackBar),
        findsNothing,
        reason: 'should not work when no scaffold is present',
      );
    });
    testWidgets(
        'GIVEN there is a scaffold '
        'WHEN `confirmDelete` is called '
        'THEN should not show', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () => confirmDelete(context),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(
        find.byType(SnackBar),
        findsOneWidget,
        reason: 'should show snackbar',
      );
    });

    testWidgets(
        'WHEN `SnackBarAction` is pressed '
        'THEN should return true', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              floatingActionButton: FloatingActionButton(onPressed: () async {
                final confirmed = await confirmDelete(context);
                expect(
                  confirmed,
                  isTrue,
                  reason: 'should return `true`',
                );
              }),
            ),
          ),
        ),
      );
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(SnackBarAction));
      await tester.pumpAndSettle();
    });
    testWidgets(
        'WHEN `SnackBarAction` is not  pressed '
        'THEN should return false', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              floatingActionButton: FloatingActionButton(onPressed: () async {
                final confirmed = await confirmDelete(context);
                expect(
                  confirmed,
                  isFalse,
                  reason: 'should return `false`',
                );
              }),
            ),
          ),
        ),
      );
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump(const Duration(seconds: 3));
    });
  });
}

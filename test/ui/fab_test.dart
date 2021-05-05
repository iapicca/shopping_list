import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_list/ui/all.dart';
import 'package:stub/stub.dart';

void main() {
  final callback = nullaryStub<void>()..stub = () {};
  final app = ProviderScope(
    child: MaterialApp(
        home: Material(
            child: AnimatedFab(
      callback: callback.wrap,
    ))),
  );
  const fabKey = ValueKey('Icon@AnimatedFab');
  group('AnimatedFab test', () {
    testWidgets('WHEN initialized ' 'THEN shows "FAB"', (tester) async {
      await tester.pumpWidget(app);
      expect(
        find.byKey(fabKey),
        findsOneWidget,
        reason: 'should find an Icon',
      );
    });
    testWidgets('WHEN onTap ' 'THEN shows "NewItem"', (tester) async {
      await tester.pumpWidget(app);
      await tester.tap(find.byKey(fabKey));
      await tester.pumpAndSettle();
      expect(
        find.byType(NewItem),
        findsOneWidget,
        reason: 'should find `NewItem`',
      );
    });
    testWidgets('WHEN onTap ' 'THEN shows "NewItem"', (tester) async {
      await tester.pumpWidget(app);
      await tester.tap(find.byKey(fabKey));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Back'));
      expect(
        callback.count,
        1,
        reason: 'callback should be called once',
      );
    });
  });
}

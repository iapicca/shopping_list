import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_list/logic/all.dart';
import 'package:shopping_list/model/all.dart';
import 'package:shopping_list/ui/all.dart';

void main() {
  final items = ValueNotifier(<Item>[]);
  final app = ProviderScope(
    overrides: [itemsPod.overrideWithValue(items)],
    child: const MaterialApp(home: Material(child: CompletedItemsList())),
  );

  group('CompletedItemsList test', () {
    testWidgets(
        'WHEN items.value.isEmpty ' 'THEN shows no `CompletedItemWidget`',
        (tester) async {
      await tester.pumpWidget(app);
      expect(
        find.byType(CompletedItemWidget),
        findsNothing,
        reason: 'should find nothing',
      );
    });
    testWidgets(
        'WHEN items.value.isNotEmpty ' 'THEN shows `CompletedItemWidget`',
        (tester) async {
      items.value = [const Item(description: 'description', done: true)];
      await tester.pumpWidget(app);
      expect(
        find.byType(CompletedItemWidget),
        findsOneWidget,
        reason: 'should find a widget',
      );
    });

    testWidgets('WHEN items are only "done" ' 'THEN shows nothing',
        (tester) async {
      items.value = [const Item(description: 'description', done: false)];
      await tester.pumpWidget(app);
      expect(
        find.byType(CompletedItemWidget),
        findsNothing,
        reason: 'should find no widget',
      );
    });
    testWidgets(
        'WHEN items.value changes '
        'THEN `CompletedItemWidget` count should change', (tester) async {
      items.value = [const Item(description: 'description', done: true)];
      await tester.pumpWidget(app);
      expect(
        find.byType(CompletedItemWidget),
        findsOneWidget,
        reason: 'should find a widget',
      );
      items.value = [
        const Item(description: 'description', done: true),
        const Item(description: 'description', done: true),
      ];
      await tester.pump();
      expect(
        find.byType(CompletedItemWidget),
        findsNWidgets(2),
        reason: 'should find 2 widgets',
      );
    });

    testWidgets(
        'WHEN a "done=false" items is added '
        'THEN `CompletedItemWidget` count should not change', (tester) async {
      items.value = [const Item(description: 'description', done: true)];
      await tester.pumpWidget(app);
      expect(
        find.byType(CompletedItemWidget),
        findsOneWidget,
        reason: 'should find a widget',
      );
      items.value = [
        const Item(description: 'description', done: false),
        const Item(description: 'description', done: true),
      ];
      await tester.pump();
      expect(
        find.byType(CompletedItemWidget),
        findsOneWidget,
        reason: 'should find a widget',
      );
    });
  });
}

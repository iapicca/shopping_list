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
    child: const MaterialApp(home: Material(child: TodoItemsList())),
  );

  group('TodoItemsList test', () {
    testWidgets('WHEN items.value.isEmpty ' 'THEN shows no `TodoItemWidget`',
        (tester) async {
      await tester.pumpWidget(app);
      expect(
        find.byType(TodoItemWidget),
        findsNothing,
        reason: 'should find nothing',
      );
    });
    testWidgets('WHEN items.value.isNotEmpty ' 'THEN shows `TodoItemWidget`',
        (tester) async {
      items.value = [const Item(description: 'description', done: false)];
      await tester.pumpWidget(app);
      expect(
        find.byType(TodoItemWidget),
        findsOneWidget,
        reason: 'should find a widget',
      );
    });

    testWidgets('WHEN items are only "done" ' 'THEN shows nothing',
        (tester) async {
      items.value = [const Item(description: 'description', done: true)];
      await tester.pumpWidget(app);
      expect(
        find.byType(TodoItemWidget),
        findsNothing,
        reason: 'should find no widget',
      );
    });
    testWidgets(
        'WHEN items.value changes ' 'THEN `TodoItemWidget` count should change',
        (tester) async {
      items.value = [const Item(description: 'description', done: false)];
      await tester.pumpWidget(app);
      expect(
        find.byType(TodoItemWidget),
        findsOneWidget,
        reason: 'should find a widget',
      );
      items.value = [
        const Item(description: 'description', done: false),
        const Item(description: 'description', done: false),
      ];
      await tester.pump();
      expect(
        find.byType(TodoItemWidget),
        findsNWidgets(2),
        reason: 'should find 2 widgets',
      );
    });

    testWidgets(
        'WHEN a "done" items is added '
        'THEN `TodoItemWidget` count should not change', (tester) async {
      items.value = [const Item(description: 'description', done: false)];
      await tester.pumpWidget(app);
      expect(
        find.byType(TodoItemWidget),
        findsOneWidget,
        reason: 'should find a widget',
      );
      items.value = [
        const Item(description: 'description', done: false),
        const Item(description: 'description', done: true),
      ];
      await tester.pump();
      expect(
        find.byType(TodoItemWidget),
        findsOneWidget,
        reason: 'should find a widget',
      );
    });
  });
}

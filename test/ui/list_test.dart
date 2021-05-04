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
    child: const MaterialApp(home: Material(child: ItemsList())),
  );

  group('ItemsList test', () {
    testWidgets('WHEN items.value.isEmpty ' 'THEN shows no `ItemWidget`',
        (tester) async {
      await tester.pumpWidget(app);
      expect(
        find.byType(ItemWidget),
        findsNothing,
        reason: 'should find nothing',
      );
    });
    testWidgets('WHEN items.value.isNotEmpty ' 'THEN shows `ItemWidget`',
        (tester) async {
      items.value = [Item.temp(description: 'description')];
      await tester.pumpWidget(app);
      expect(
        find.byType(ItemWidget),
        findsOneWidget,
        reason: 'should find a widget',
      );
    });
    testWidgets(
        'WHEN items.value changes ' 'THEN `ItemWidget` count should change',
        (tester) async {
      items.value = [Item.temp(description: 'description')];
      await tester.pumpWidget(app);
      expect(
        find.byType(ItemWidget),
        findsOneWidget,
        reason: 'should find a widget',
      );
      items.value = [
        Item.temp(description: 'description'),
        Item.temp(description: 'description'),
      ];
      await tester.pump();
      expect(
        find.byType(ItemWidget),
        findsNWidgets(2),
        reason: 'should find 2 widgets',
      );
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_list/logic/all.dart';
import 'package:shopping_list/model/all.dart';
import 'package:shopping_list/ui/all.dart';
import 'package:stub/stub.dart';

void main() {
  final edit = unaryStub<void, Item>()..stub = (_) {};
  final remove = unaryStub<void, Item>()..stub = (_) {};

  final app = ProviderScope(
    overrides: [
      editItemPod.overrideWithValue(edit.wrap),
      removeItemPod.overrideWithValue(remove.wrap),
    ],
    child: MaterialApp(
      home: Material(
        child: ListView(
          children: [
            TodoItemWidget(
              item: Item.temp(description: 'description'),
            )
          ],
        ),
      ),
    ),
  );

  group('TodoItemWidget test', () {
    testWidgets('WHEN swiped `left` ' 'THEN should call `remove`',
        (tester) async {
      edit.reset;
      remove.reset;

      await tester.pumpWidget(app);
      final swipe = tester.getRect(find.byType(ListView)).width;
      await tester.drag(find.byType(ListTile), Offset(-swipe, 0));
      await tester.pumpAndSettle();
      expect(
        edit.count,
        0,
        reason: '`edit` shuld NOT be called',
      );
      expect(
        remove.count,
        1,
        reason: '`remove` shuld be called 1',
      );
    });
    testWidgets('WHEN swiped `right` ' 'THEN should call `edit`',
        (tester) async {
      edit.reset;
      remove.reset;
      await tester.pumpWidget(app);
      final swipe = tester.getRect(find.byType(ListView)).width;
      await tester.drag(find.byType(ListTile), Offset(swipe, 0));
      await tester.pumpAndSettle();
      expect(
        edit.count,
        1,
        reason: '`edit` shuld be called once',
      );
      expect(
        remove.count,
        0,
        reason: '`remove` shuld NOT be called',
      );
    });
  });
}

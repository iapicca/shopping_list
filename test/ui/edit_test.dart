import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_list/logic/all.dart';
import 'package:shopping_list/model/all.dart';
import 'package:shopping_list/ui/all.dart';
import 'package:stub/stub.dart';

void main() {
  const duration = Duration(milliseconds: 50);
  const descriptionFieldKey = ValueKey('TextFormField:description@EditItem');
  final edit = unaryStub<void, Item>()..stub = (_) {};
  final app = ProviderScope(
    overrides: [editItemPod.overrideWithValue(edit.wrap)],
    child: MaterialApp(home: EditItem(Item.temp(description: 'description'))),
  );

  group('EditItem test', () {
    testWidgets(
        'GIVEN `item` is unchanged'
        'WHEN `fab` pressed '
        'THEN `edit` should not be called', (tester) async {
      /// `https://github.com/iapicca/shopping_list/issues/7`
      edit.reset;
      await tester.pumpWidget(app);
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump(duration);

      expect(
        edit.count,
        0,
        reason: '`edit` should NOT be called',
      );
    });

    testWidgets(
        'GIVEN `description` changed '
        'WHEN `fab` pressed '
        'THEN edit is called', (tester) async {
      edit.reset;
      await tester.pumpWidget(app);
      await tester.enterText(
          find.byKey(descriptionFieldKey), 'new description');
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();
      expect(
        edit.count,
        1,
        reason: '`edit` should be called',
      );
    });
  });
}

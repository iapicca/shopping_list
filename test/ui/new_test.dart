import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_list/logic/all.dart';
import 'package:shopping_list/model/all.dart';
import 'package:shopping_list/ui/all.dart';
import 'package:stub/stub.dart';

void main() {
  const duration = Duration(milliseconds: 50);
  const descriptionFieldKey = ValueKey('TextFormField:description@NewItem');
  final add = unaryStub<void, Item>()..stub = (_) {};
  final app = ProviderScope(
    overrides: [addItemPod.overrideWithValue(add.wrap)],
    child: MaterialApp(home: NewItem()),
  );

  group('NewItem test', () {
    testWidgets(
        'GIVEN `description` isEmpty '
        'WHEN `fab` pressed '
        'THEN `snakbar` is shown', (tester) async {
      add.reset;
      await tester.pumpWidget(app);
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump(duration);
      expect(
        find.byType(SnackBar),
        findsOneWidget,
        reason: '`snackbar` should be shown',
      );
      expect(
        add.count,
        0,
        reason: '`add` should NOT be called',
      );
    });
    testWidgets(
        'GIVEN `description` isNotEmpty '
        'WHEN `fab` pressed '
        'THEN add is called', (tester) async {
      add.reset;
      await tester.pumpWidget(app);
      await tester.enterText(find.byKey(descriptionFieldKey), 'description');
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();
      expect(
        add.count,
        1,
        reason: '`add` should be called',
      );
    });
  });
}

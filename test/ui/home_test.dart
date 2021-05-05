import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_list/logic/all.dart';
import 'package:shopping_list/model/all.dart';
import 'package:shopping_list/ui/all.dart';
import 'package:stub/stub.dart';

void main() {
  const descriptionFieldKey = ValueKey('TextFormField:description@NewItem');
  final fetch = nullaryStub()..stub = () {};
  final add = unaryStub<void, Item>()..stub = (_) {};
  final connectivity = ValueNotifier(ConnectivityResult.wifi);

  final app = ProviderScope(
    overrides: [
      fetchItemsPod.overrideWithValue(fetch.wrap),
      addItemPod.overrideWithValue(add.wrap),
      connectivityResultPod.overrideWithValue(connectivity),
    ],
    child: const MaterialApp(home: Material(child: HomePage())),
  );

  group('HomePage test', () {
    testWidgets('WHEN widget is initialized ' 'THEN `fetch` should be called',
        (tester) async {
      await tester.pumpWidget(app);

      expect(
        fetch.count,
        1,
        reason: '`fetch` should called once',
      );
    });
    testWidgets(
        'GIVEN tab is `completed` '
        'WHEN `animatedfab` completes  '
        'THEN tab should be todo', (tester) async {
      await tester.pumpWidget(app);
      await tester.tap(find.byKey(const ValueKey('Tab:completed@HomePage')));
      await tester.pumpAndSettle();

      expect(
        find.byKey(const ValueKey('CompletedList')),
        findsOneWidget,
        reason: 'should find `CompletedList`',
      );

      await tester.tap(find.byKey(const ValueKey('Icon@AnimatedFab')));
      await tester.pumpAndSettle();
      expect(
        find.byKey(descriptionFieldKey),
        findsOneWidget,
        reason: 'should find `TextFormField:description`',
      );
      expect(
        find.byKey(const ValueKey('FloatingActionButton@NewItem')),
        findsOneWidget,
        reason: 'should find `FloatingActionButton`',
      );

      await tester.enterText(find.byKey(descriptionFieldKey), 'description');
      await tester.pumpAndSettle();

      await tester
          .tap(find.byKey(const ValueKey('FloatingActionButton@NewItem')));

      await tester.pumpAndSettle();
      expect(
        find.byKey(const ValueKey('TodoItemsList')),
        findsOneWidget,
        reason: 'should find `TodoItemsList`',
      );
    });

    testWidgets('WHEN `ConnectivityResult.none` ' 'THEN  ... ', (tester) async {
      connectivity.value = ConnectivityResult.none;

      await tester.pumpWidget(app);
      await tester.pump(const Duration(milliseconds: 100));
    });
  });
}

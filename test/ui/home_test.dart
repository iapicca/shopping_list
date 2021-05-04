import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_list/logic/all.dart';
import 'package:shopping_list/ui/all.dart';
import 'package:stub/stub.dart';

void main() {
  final fetch = nullaryStub()..stub = () {};
  final app = ProviderScope(
    overrides: [fetchItemsPod.overrideWithValue(fetch.wrap)],
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
  });
}

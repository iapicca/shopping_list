import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_list/logic/all.dart';
import 'package:shopping_list/logic/snack/on_error.dart';
import 'package:shopping_list/model/all.dart';
import 'package:stub/stub.dart';

void main() {
  group('onErrorSnackCallbackPod & memoizedOnErrorSnackCallbackPod test', () {
    final errorSnack = nullaryStub<void>()..stub = () {};
    final errorCallback = ValueNotifier<VoidCallback?>(errorSnack.wrap);
    final container = ProviderContainer(
      overrides: [
        onErrorSnackCallbackPod.overrideWithValue(errorCallback),
      ],
    );

    /// onErrorPod
    test(
        'WHEN container.read(onErrorSnackCallbackPod)'
        'THEN returns `ValueNotifier<VoidCallback?>`', () {
      expect(
        container.read(onErrorSnackCallbackPod),
        isA<ValueNotifier<VoidCallback?>>(),
        reason: 'should return a `ValueNotifier<VoidCallback?>`',
      );
    });
    test(
        'WHEN container.read(memoizedOnErrorSnackCallbackPod)'
        'THEN returns `void Function(BuildContext)>`', () {
      expect(
        container.read(memoizedOnErrorSnackCallbackPod),
        isA<void Function(BuildContext)>(),
        reason: 'should return a `void Function(BuildContext)`',
      );
    });
    test(
        'WHEN onErrorPod is called'
        'THEN is called onErrorSnackCallbackPod`', () {
      final onError = container.read(onErrorPod);
      onError(const FailureReport(null, null));
      expect(
        errorSnack.count > 0,
        isTrue,
        reason: 'error snack should be called',
      );
    });
    testWidgets(
        'GIVEN `errorSnackbar`'
        'WHEN `fab` pressed '
        'THEN `edit` should not be called', (tester) async {
      final app = MaterialApp(
        home: Scaffold(
            floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            onPressed: () => errorSnackbar(context),
          ),
        )),
      );
      await tester.pumpWidget(app);
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(
        find.byType(SnackBar),
        findsOneWidget,
        reason: 'should find a `SnackBar`',
      );
    });
  });
}

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_list/domain/all.dart';
import 'package:shopping_list/logic/all.dart';
import 'package:shopping_list/model/all.dart';

import 'package:stub/stub.dart';

void main() {
  final item = Item.temp(description: 'description');

  final delay = const Duration(milliseconds: 50);
  final deleteItemStub = unaryStub<Future<Result>, Item>()
    ..stub = (_) async {
      await Future.delayed(delay * 2);
      return const Failure(FailureReport(null, null));
    };
  final itemsNotifier = ValueNotifier<List<Item>>([item]);
  final onErrorStub = unaryStub<void, FailureReport>()..stub = (_) {};
  final container = ProviderContainer(
    overrides: [
      deleteItemPod
          .overrideWithProvider(Provider((ref) => deleteItemStub.wrap)),
      itemsPod
          .overrideWithProvider(Provider.autoDispose((ref) => itemsNotifier)),
      onErrorPod.overrideWithProvider(Provider((ref) => onErrorStub.wrap)),
    ],
  );
  final removeItem = container.read(removeItemPod);
  final listNotifier = container.read(itemsPod);

  group('editItemPod test ', () {
    test(
        'GIVEN `deleteItem` fails '
        'WHEN  item is removed '
        'THEN removed first and then restored', () async {
      removeItem(item);
      await Future.delayed(delay);
      expect(
        listNotifier.value.length,
        0,
        reason: 'item should delete',
      );
      await Future.delayed(delay * 2);
      expect(
        listNotifier.value.length,
        1,
        reason: 'deletion should be undone',
      );
      expect(
        onErrorStub.count,
        1,
        reason: '`onError` should be called once',
      );
    });
    test(
        'GIVEN `deleteItem` succeeds '
        'WHEN  item is removed '
        'THEN removed with no further actions ', () async {
      deleteItemStub.stub = (_) async {
        await Future.delayed(delay * 2);
        return const Success(null);
      };
      onErrorStub.reset;

      removeItem(item);
      await Future.delayed(delay);
      expect(
        listNotifier.value.length,
        0,
        reason: 'item should delete',
      );
      await Future.delayed(delay * 2);
      expect(
        listNotifier.value.length,
        0,
        reason: 'deletion should persist',
      );
      expect(
        onErrorStub.count,
        0,
        reason: '`onError` should NOT be called',
      );
    });
  });
}

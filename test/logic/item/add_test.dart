import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_list/domain/all.dart';
import 'package:shopping_list/logic/all.dart';
import 'package:shopping_list/model/all.dart';
import 'package:stub/stub.dart';

void main() {
  final delay = const Duration(milliseconds: 50);
  final createItemStub = unaryStub<Future<Result<Item>>, Item>()
    ..stub = (_) async {
      await Future.delayed(delay * 2);
      return const Failure(FailureReport(null, null));
    };
  final itemsNotifier = ValueNotifier<List<Item>>([]);
  final onErrorStub = unaryStub<void, FailureReport>()..stub = (_) {};

  final container = ProviderContainer(
    overrides: [
      createItemPod
          .overrideWithProvider(Provider((ref) => createItemStub.wrap)),
      itemsPod.overrideWithProvider(Provider((ref) => itemsNotifier)),
      onErrorPod.overrideWithProvider(Provider((ref) => onErrorStub.wrap)),
    ],
  );
  final addItem = container.read(addItemPod);
  final item = Item.temp(description: 'description');
  group('addItemPod test ', () {
    test(
        'GIVEN `createItem` fail '
        'WHEN  item is added '
        'THEN is added first and then removed', () async {
      addItem(item);
      await Future.delayed(delay);
      expect(
        itemsNotifier.value.length,
        1,
        reason: 'item should be added to list',
      );
      await Future.delayed(delay * 2);
      expect(
        itemsNotifier.value.length,
        0,
        reason: 'item should be THEN removed from list',
      );
      expect(
        onErrorStub.count,
        1,
        reason: '`onError` should be called once',
      );
    });
    test(
        'GIVEN `createItem` succeed '
        'WHEN  item is added '
        'THEN item is added and the updated', () async {
      const ok = Item(description: 'description', id: 'ID');
      createItemStub.stub = (_) async {
        await Future.delayed(delay * 2);
        return const Success(ok);
      };
      onErrorStub.reset;
      addItem(item);
      await Future.delayed(delay);
      expect(
        itemsNotifier.value.length,
        1,
        reason: 'item should be added to list',
      );
      await Future.delayed(delay * 2);
      expect(
        itemsNotifier.value.length,
        1,
        reason: 'item is not removed from list',
      );
      expect(
        itemsNotifier.value.first.id,
        ok.id,
        reason: 'item id is updated',
      );
      expect(
        onErrorStub.count,
        0,
        reason: '`onError` should NOT be calles',
      );
    });
  });
}

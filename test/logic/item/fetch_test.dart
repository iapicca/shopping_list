import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_list/domain/all.dart';
import 'package:shopping_list/logic/all.dart';
import 'package:shopping_list/model/all.dart';
import 'package:stub/stub.dart';

void main() {
  final delay = const Duration(milliseconds: 50);
  final readItemStub = nullaryStub<Future<Result<List<Item>>>>()
    ..stub = () async {
      await Future.delayed(delay);
      return const Failure(FailureReport(null, null));
    };
  final itemsNotifier = ValueNotifier<List<Item>>([]);
  final onErrorStub = unaryStub<void, FailureReport>()..stub = (_) {};

  final item = Item.temp(description: 'description');
  final container = ProviderContainer(
    overrides: [
      readItemPod.overrideWithProvider(Provider((ref) => readItemStub.wrap)),
      itemsPod
          .overrideWithProvider(Provider.autoDispose((ref) => itemsNotifier)),
      onErrorPod.overrideWithProvider(Provider((ref) => onErrorStub.wrap)),
    ],
  );
  final fetchItem = container.read(fetchItemsPod);
  group('addItemPod test ', () {
    test(
        'GIVEN `readItem` fail '
        'WHEN  fetch is ccalled '
        'THEN no items are added', () async {
      fetchItem();
      await Future.delayed(delay * 2);
      expect(
        itemsNotifier.value.length,
        0,
        reason: 'item should NOT be added to list',
      );
      expect(
        onErrorStub.count,
        1,
        reason: '`onError` should be called once',
      );
    });
    test(
        'GIVEN `readItem` succeeds '
        'WHEN  fetch is called '
        'THEN  items are added', () async {
      readItemStub.stub = () async {
        await Future.delayed(delay * 2);
        return Success([item]);
      };
      onErrorStub.reset;
      fetchItem();
      await Future.delayed(delay * 2);
      expect(
        itemsNotifier.value.length,
        1,
        reason: 'item should be added to list',
      );
      expect(
        onErrorStub.count,
        0,
        reason: '`onError` should NOT be called',
      );
    });
    test(
        'GIVEN list contains items '
        'WHEN  fetch fails '
        'THEN  items are removed', () async {
      readItemStub.stub = () async {
        await Future.delayed(delay * 2);
        return const Failure(FailureReport(null, null));
      };
      onErrorStub.reset;
      expect(
        itemsNotifier.value.length,
        1,
        reason: 'item should be present in list',
      );
      fetchItem();
      await Future.delayed(delay * 2);
      expect(
        itemsNotifier.value.length,
        0,
        reason: 'list should be empty',
      );
      expect(
        onErrorStub.count,
        1,
        reason: '`onError` should be called once',
      );
    });
  });
}

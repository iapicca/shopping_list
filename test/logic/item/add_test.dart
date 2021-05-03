import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_list/domain/all.dart';
import 'package:shopping_list/logic/all.dart';
import 'package:shopping_list/model/all.dart';
import 'package:stub/stub.dart';

void main() {
  final delay = const Duration(milliseconds: 200);
  final createItemStub = unaryStub<Future<Result<Item>>, Item>()
    ..stub = (_) async {
      await Future.delayed(delay * 2);
      return const Failure(FailureReport(null, null));
    };
  final itemsNotifier = ValueNotifier<List<Item>>([]);
  final onErrorStub = unaryStub<void, FailureReport>()..stub = (_) {};

  final item = Item.temp(description: 'description');
  group('addItemPod test', () {
    final container = ProviderContainer(
      overrides: [
        createItemPod
            .overrideWithProvider(Provider((ref) => createItemStub.wrap)),
        itemsPod
            .overrideWithProvider(Provider.autoDispose((ref) => itemsNotifier)),
        onErrorPod.overrideWithProvider(Provider((ref) => onErrorStub.wrap)),
      ],
    );
    final addItem = container.read(addItemPod);
    test('GIVEN `createItem` fail' 'WHEN ', () async {
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
  });
}

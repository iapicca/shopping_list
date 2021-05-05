import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_list/domain/all.dart';
import 'package:shopping_list/logic/all.dart';
import 'package:shopping_list/model/all.dart';
import 'package:shopping_list/extension/all.dart';

import 'package:stub/stub.dart';

import '../../mocks/all.dart';

void main() {
  final item = Item.fromJson(jsonDecode(fakeITEM));
  final description = item.description;
  final delay = const Duration(milliseconds: 50);
  final editItemStub = unaryStub<Future<Result>, Item>()
    ..stub = (_) async {
      await Future.delayed(delay * 2);
      return const Failure(FailureReport(null, null));
    };
  final itemsNotifier = ValueNotifier<List<Item>>([item]);
  final onErrorStub = unaryStub<void, FailureReport>()..stub = (_) {};
  const redact = 'new description';
  final container = ProviderContainer(
    overrides: [
      updateItemPod.overrideWithProvider(Provider((ref) => editItemStub.wrap)),
      itemsPod.overrideWithProvider(Provider((ref) => itemsNotifier)),
      onErrorPod.overrideWithProvider(Provider((ref) => onErrorStub.wrap)),
    ],
  );
  final editItem = container.read(editItemPod);
  final listNotifier = container.read(itemsPod);

  group('editItemPod test ', () {
    test(
        'GIVEN `updateItem` fail '
        'WHEN  item is edited '
        'THEN change first and then restored', () async {
      editItem(item.copyWith(description: redact));
      await Future.delayed(delay);
      expect(
        listNotifier.value.first.description,
        redact,
        reason: 'item should edited',
      );
      await Future.delayed(delay * 2);
      expect(
        listNotifier.value.first.description,
        description,
        reason: 'edit should be undone',
      );
      expect(
        onErrorStub.count,
        1,
        reason: '`onError` should be called once',
      );
    });
    test(
        'GIVEN `updateItem` succeeds '
        'WHEN  item is edited '
        'THEN changes with no further actions ', () async {
      editItemStub.stub = (_) async {
        await Future.delayed(delay * 2);
        return const Success(null);
      };
      onErrorStub.reset;

      editItem(item.copyWith(description: redact));
      await Future.delayed(delay);
      expect(
        listNotifier.value.first.description,
        redact,
        reason: 'item should edited',
      );
      await Future.delayed(delay * 2);
      expect(
        listNotifier.value.first.description,
        redact,
        reason: 'edit should be undone',
      );
      expect(
        onErrorStub.count,
        0,
        reason: '`onError` should be called once',
      );
    });
  });
}

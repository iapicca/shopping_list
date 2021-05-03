import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_list/domain/all.dart';
import 'package:shopping_list/model/all.dart';

import '../all.dart';

/// an `optimistic` approach that immediately `add` the new item
/// in case of failure reverse the change
/// in case of success the item replaced with the new id
final addItemPod = Provider<void Function(Item)>((ref) {
  final create = ref.read(createItemPod);
  final items = ref.read(itemsPod);
  final onError = ref.read(onErrorPod);
  return (item) async {
    final current = items.value;
    items.value = [item, ...current];
    final result = await create(item);
    if (result is Failure) {
      items.value = current;
      onError((result as Failure).report);
    } else {
      final list = items.value..removeWhere((i) => i.id == item.id);
      items.value = [(result as Success<Item>).data, ...list];
    }
  };
});

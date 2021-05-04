import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_list/domain/all.dart';
import 'package:shopping_list/model/all.dart';

import '../all.dart';

/// an `optimistic` approach that immediately `remove` the item
/// in case of failure reverse the change

final removeItemPod = Provider<void Function(Item)>((ref) {
  final delete = ref.read(deleteItemPod);
  final items = ref.read(itemsPod);
  final onError = ref.read(onErrorPod);
  return (item) async {
    final current = List<Item>.unmodifiable(<Item>[...items.value]);
    final redacted = [...current]..removeWhere((i) => i.id == item.id);
    items.value = redacted;
    if (item.id == null) {
      return;
    }
    final result = await delete(item);
    if (result is Failure) {
      items.value = current;
      onError(result.report);
    }
  };
});

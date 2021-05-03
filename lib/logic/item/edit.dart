import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_list/domain/all.dart';
import 'package:shopping_list/model/all.dart';

import '../all.dart';

/// an `optimistic` approach that immediately `edit` the new item
/// in case of failure reverse the change
final editItemPod = Provider<void Function(Item)>((ref) {
  final update = ref.read(updateItemPod);
  final items = ref.read(itemsPod);
  final onError = ref.read(onErrorPod);
  return (item) async {
    final current = items.value;
    final redacted = items.value..removeWhere((i) => i.id == item.id);
    items.value = [item, ...redacted];
    final result = await update(item);
    if (result is Failure) {
      items.value = current;
      onError(result.report);
    }
  };
});

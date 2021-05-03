import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_list/domain/all.dart';
import 'package:shopping_list/model/all.dart';

import '../all.dart';

/// a `Provider` that provides a `callback` that "fetch" the items
final fetchItemsPod = Provider<void Function()>((ref) {
  final items = ref.read(itemsPod);
  final onError = ref.read(onErrorPod);
  final readItems = ref.read(readItemPod);

  return () async {
    final result = await readItems();
    if (result is Failure) {
      onError((result as Failure).report);
      items.value = [];
    } else {
      items.value = (result as Success<List<Item>>).data;
    }
  };
});

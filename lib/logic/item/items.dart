import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_list/model/all.dart';

/// a `Provider` for `ValueNotifier<List<Item>>`
final itemsPod = Provider<ValueNotifier<List<Item>>>((ref) {
  final notifier = ValueNotifier<List<Item>>([]);
  return notifier;
});

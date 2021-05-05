import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_list/logic/all.dart';
import 'package:shopping_list/model/all.dart';
import 'package:shopping_list/ui/all.dart';

/// the a list view of the items
class CompletedItemsList extends HookWidget {
  /// allows a `const` constructor
  const CompletedItemsList() : super(key: const ValueKey('CompletedList'));

  @override
  Widget build(BuildContext context) {
    final list = useProvider(itemsPod);
    return ValueListenableBuilder<List<Item>>(
        key: const ValueKey('ValueListenableBuilder@CompletedList'),
        valueListenable: list,
        builder: (context, items, child) {
          final done = [
            for (final item in items)
              if (item.done) item
          ];
          return ListView.builder(
              key: const ValueKey('ListView@CompletedList'),
              itemCount: done.length,
              itemBuilder: (context, index) {
                return CompletedItemWidget(item: done[index]);
              });
        });
  }
}

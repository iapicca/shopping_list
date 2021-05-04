import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_list/logic/all.dart';
import 'package:shopping_list/model/all.dart';

import 'all.dart';

/// the a list view of the items
class ItemsList extends HookWidget {
  /// allows a `const` constructor
  const ItemsList() : super(key: const ValueKey('ItemsList'));

  @override
  Widget build(BuildContext context) {
    final list = useProvider(itemsPod);
    return ValueListenableBuilder<List<Item>>(
        key: ValueKey('ValueListenableBuilder@$key'),
        valueListenable: list,
        builder: (context, items, child) {
          return ListView.builder(
              key: ValueKey('ListView@$key'),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ItemWidget(item: items[index]);
              });
        });
  }
}

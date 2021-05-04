import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_list/logic/all.dart';
import 'package:shopping_list/model/all.dart';
import 'package:shopping_list/extension/all.dart';
import 'package:shopping_list/ui/edit.dart';

/// a shopping list item
class ItemWidget extends HookWidget {
  /// wraps an `Item` model
  ItemWidget({required this.item})
      : super(key: ValueKey('ItemWidget:${item.id}'));

  /// the `Item` model
  final Item item;

  @override
  Widget build(BuildContext context) {
    final edit = useProvider(editItemPod);
    final remove = useProvider(removeItemPod);
    return Dismissible(
      background: const ColoredBox(color: Colors.green),
      secondaryBackground: const ColoredBox(color: Colors.red),
      key: UniqueKey(),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          edit(item.copyWith(done: true));
        }
        if (direction == DismissDirection.endToStart) {
          remove(item);
        }
      },
      child: OpenContainer<Item>(
        key: ValueKey('OpenContainer@$key'),
        transitionType: ContainerTransitionType.fade,
        closedBuilder: (context, action) {
          return ListTile(
            key: Key('ListTile@$key'),
            leading: Text('Q.ty. ${item.quantity}'),
            title: Center(child: Text(item.description)),
            subtitle: Center(child: Text(item.note)),
          );
        },
        closedElevation: 6.0,
        closedColor: Theme.of(context).colorScheme.secondary,
        openBuilder: (context, action) => EditItem(item),
      ),
    );
  }
}

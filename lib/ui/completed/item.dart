import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_list/logic/all.dart';
import 'package:shopping_list/model/all.dart';
import 'package:shopping_list/extension/all.dart';
import 'package:shopping_list/ui/all.dart';

/// a shopping list item
class CompletedItemWidget extends HookWidget {
  /// wraps an `Item` model
  CompletedItemWidget({required this.item})
      : super(key: ValueKey('CompletedItemWidget:${item.id}'));

  /// the `Item` model
  final Item item;

  @override
  Widget build(BuildContext context) {
    final edit = useProvider(editItemPod);
    final remove = useProvider(removeItemPod);
    final confirmDelete = useProvider(confirmDeletePod);
    return Dismissible(
      background: DismissibleBackGround.restore,
      secondaryBackground: DismissibleBackGround.delete,
      key: UniqueKey(),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          edit(item.copyWith(done: false));
        }
        if (direction == DismissDirection.endToStart) {
          remove(item);
        }
      },
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          return true;
        }
        return await confirmDelete(context);
      },
      child: ListTile(
        key: Key('ListTile@$key'),
        leading: Text('Q.ty. ${item.quantity}'),
        title: Center(child: Text(item.description)),
        subtitle: Center(child: Text(item.note)),
        trailing: OpenContainer<Item>(
          key: ValueKey('OpenContainer@$key'),
          transitionType: ContainerTransitionType.fade,
          closedElevation: 0,
          closedBuilder: (context, action) => const SizedBox(
            height: 56,
            width: 56,
            child: Icon(Icons.edit),
          ),
          openBuilder: (context, action) => EditItem(item),
        ),
      ),
    );
  }
}

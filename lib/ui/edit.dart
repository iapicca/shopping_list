import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_list/extension/all.dart';
import 'package:shopping_list/logic/all.dart';
import 'package:shopping_list/model/all.dart';

/// a page for editing an `Item`
class EditItem extends HookWidget {
  /// doesn't have any parameter
  const EditItem(this.item) : super(key: const ValueKey('EditItem'));

  /// the item being edited
  final Item item;

  static const _focused = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 3),
  );
  static const _enabled = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 1),
  );

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final descriptionController = useTextEditingController()
      ..text = item.description;
    final noteController = useTextEditingController()..text = item.note;

    final quantity = useValueNotifier<int>(item.quantity);
    final edit = useProvider(editItemPod);

    return Scaffold(
      key: const ValueKey('Scaffold@EditItem'),
      appBar: AppBar(
          key: const ValueKey('AppBar@EditItem'),
          title: const Text('Edit Item')),
      body: Form(
        key: formKey,
        child: Padding(
          key: const ValueKey('Padding@EditItem'),
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * .2,
          ),
          child: Column(
            key: const ValueKey('Column@EditItem'),
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                key: const ValueKey('TextFormField:description@EditItem'),
                controller: descriptionController,
                validator: (String? value) => value == null || value.isEmpty
                    ? 'Please enter a description'
                    : null,
                decoration: const InputDecoration(
                  focusedBorder: _focused,
                  enabledBorder: _enabled,
                  hintText: 'User name',
                ),
              ),
              TextFormField(
                key: const ValueKey('TextFormField:note@EditItem'),
                controller: noteController,
                decoration: const InputDecoration(
                  focusedBorder: _focused,
                  enabledBorder: _enabled,
                  hintText: 'User name',
                ),
              ),
              SizedBox(
                key: const ValueKey('SizedBox@EditItem'),
                width: MediaQuery.of(context).size.width * .5,
                child: Row(
                  key: const ValueKey('Row@EditItem'),
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      key: const ValueKey('IconButton:remove@EditItem'),
                      icon: const Icon(Icons.remove),
                      iconSize: 18,
                      onPressed: () =>
                          quantity.value > 0 ? quantity.value-- : null,
                    ),
                    ValueListenableBuilder<int>(
                        valueListenable: quantity,
                        builder: (context, value, child) {
                          return Center(child: Text('$value'));
                        }),
                    IconButton(
                      key: const ValueKey('IconButton:add@EditItem'),
                      icon: const Icon(Icons.add),
                      iconSize: 18,
                      onPressed: () => quantity.value++,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: const ValueKey('FloatingActionButton@EditItem'),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            if ((descriptionController.text != item.description) ^
                (noteController.text != item.note) ^
                (quantity.value != item.quantity)) {
              edit(item.copyWith(
                description: descriptionController.text,
                note: noteController.text,
                quantity: quantity.value,
              ));
            }
            Navigator.pop<Item?>(context, null);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('please add a description'),
              duration: Duration(seconds: 1),
            ));
          }
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_list/logic/all.dart';
import 'package:shopping_list/model/all.dart';

/// a page for the creation of a new `Item`
class NewItem extends HookWidget {
  /// doesn't have any parameter
  NewItem() : super(key: const ValueKey('NewItem'));

  static const _focused = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 3),
  );
  static const _enabled = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 1),
  );

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final descriptionController = useTextEditingController();
    final noteController = useTextEditingController();
    final quantity = useValueNotifier<int>(1);
    final add = useProvider(addItemPod);

    return Scaffold(
      key: const ValueKey('Scaffold@NewItem'),
      appBar: AppBar(title: const Text('New Item')),
      body: Form(
        key: _formKey,
        child: Padding(
          key: const ValueKey('Scaffold@NewItem'),
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * .2,
          ),
          child: Column(
            key: const ValueKey('Column@NewItem'),
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                key: const ValueKey('TextFormField:description@NewItem'),
                controller: descriptionController,
                validator: (String? value) => value == null || value.isEmpty
                    ? 'Please enter a description'
                    : null,
                decoration: const InputDecoration(
                  focusedBorder: _focused,
                  enabledBorder: _enabled,
                  hintText: 'description',
                ),
              ),
              TextFormField(
                controller: noteController,
                decoration: const InputDecoration(
                  focusedBorder: _focused,
                  enabledBorder: _enabled,
                  hintText: 'notes',
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
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
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            add(Item.temp(
              description: descriptionController.text,
              note: noteController.text,
              quantity: quantity.value,
            ));
            Navigator.pop<Item?>(context, null);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('please add a description'),
              duration: Duration(seconds: 1),
            ));
          }
        },
        child: const Icon(Icons.done),
      ),
    );
  }
}

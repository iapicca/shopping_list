import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_list/model/all.dart';
import 'package:shopping_list/extension/all.dart';

void main() {
  const item = Item(description: 'DESCRIPTION', id: 'ID');
  const newQuantity = 2;
  const newDesription = 'newDesription';
  const newNote = 'newNote';
  const newDone = true;
  group('`Item.toJson` test', () {
    test(
        'WHEN `Item.copyWith '
        'THEN a new Item is returned', () {
      final newItem = item.copyWith(
          description: newDesription,
          done: newDone,
          note: newNote,
          quantity: newQuantity);
      expect(
        newItem.id,
        item.id,
        reason: '`id` should be unchanged',
      );

      expect(
        newItem.description,
        newDesription,
        reason: '`description` should change',
      );

      expect(
        newItem.done,
        newDone,
        reason: '`done` should change',
      );
      expect(
        newItem.note,
        newNote,
        reason: '`note` should change',
      );
      expect(
        newItem.quantity,
        newQuantity,
        reason: '`quantity` should change',
      );
    });
  });
}

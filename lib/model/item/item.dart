import 'package:equatable/equatable.dart';

/// a class representing a `shoppig list item`
class Item extends Equatable {
  /// allow a const const constructor
  const Item({
    required this.description,
    this.done = false,
    required this.id,
    this.quantity = 1,
    this.note = '',
  });

  /// returns an `Item` from a `"json"`
  factory Item.fromJson(Map<String, Object?> json) {
    return Item(
      description: json['description'] as String,
      done: json['done'] as bool,
      id: json['id'] as String,
      quantity: json['quantity'] as int,
      note: json['note'] as String,
    );
  }

  /// describe the item
  final String description;

  /// describe the status item
  final bool done;

  /// provide a unique id for the item
  final String id;

  /// add a more granula description to the item
  final String note;

  /// indicates how many `copies` of the item are needed
  final int quantity;

  @override
  List<Object> get props => [description, done, id, note, quantity];
}

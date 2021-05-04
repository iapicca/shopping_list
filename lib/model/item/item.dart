/// a class representing a `shoppig list item`
class Item {
  /// allow a const const constructor
  const Item({
    required this.description,
    this.done = false,
    this.id,
    this.quantity = 1,
    this.note = '',
  });

  /// create a Item with a temporary id
  factory Item.temp({
    required String description,
    int quantity = 1,
    String note = '',
  }) {
    return Item(
      description: description,
      quantity: quantity,
      note: note,
    );
  }

  /// returns an `Item` from a `"json"`
  factory Item.fromJson(Map<String, Object?> json) {
    return Item(
      description: json['description'] as String,
      done: json['done'] as bool,
      id: json['objectId'] as String,
      quantity: json['quantity'] as int,
      note: json['note'] as String,
    );
  }

  /// describe the item
  final String description;

  /// describe the status item
  final bool done;

  /// provide a unique id for the item
  final String? id;

  /// add a more granula description to the item
  final String note;

  /// indicates how many `copies` of the item are needed
  final int quantity;
}

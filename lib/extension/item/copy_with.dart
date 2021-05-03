import 'package:shopping_list/model/all.dart';

/// an extension on `Item`
extension ItemCopyWithX on Item {
  /// returns a `Item` with new parameters
  /// `id` cannot be changed
  Item copyWith({
    String? description,
    bool? done,
    int? quantity,
    String? note,
  }) {
    return Item(
      description: description ?? this.description,
      done: done ?? this.done,
      id: id,
      quantity: quantity ?? this.quantity,
      note: note ?? this.note,
    );
  }
}

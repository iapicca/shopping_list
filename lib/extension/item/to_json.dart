import 'dart:convert';

import '../../../model/all.dart';

/// an extension on `Item`
extension ItemToJsonX on Item {
  /// returns a `String` representing `Item` as `json`
  String get toJson {
    return jsonEncode({
      'description': description,
      'done': done,
      'id': id,
      'note': note,
      'quantity': quantity,
    });
  }
}

import 'dart:convert';

import '../../../model/all.dart';

/// an extension on `Item`
extension ItemToJsonX on Item {
  /// returns a `String` representing `Item` as `json`
  String get toJson => id == null
      ? jsonEncode({
          'description': description,
          'done': done,
          'note': note,
          'quantity': quantity,
        })
      : jsonEncode({
          'description': description,
          'done': done,
          'objectId': id,
          'note': note,
          'quantity': quantity,
        });
}

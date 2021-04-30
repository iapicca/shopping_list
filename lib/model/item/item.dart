import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart';

part 'item.freezed.dart';

/// command  to run freezed
/// `flutter pub run build_runner watch --delete-conflicting-outputs`

/// a `data class` that represent `"shopping list"` item
/// it uses `freezed` for `copyWith`, `fromJson` and `toJson`
@freezed
class Item with _$Item {
  /// the implementation is provided by `freezed`
  const factory Item({
    required DateTime date,
    required String description,
    @Default(0) int done,
    required String id,
    @Default('') String note,
    @Default(1) int quantity,
  }) = _Item;

  /// a
  // factory Item.fromJson(Map<String, Object?> json) => _$ItemFromJson(json);
}

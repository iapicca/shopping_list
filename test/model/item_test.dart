import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_list/model/all.dart';

import '../mocks/item.dart';

void main() {
  group('Item test', () {
    test(
        'GIVEN a INVALID json is provided '
        'WHEN json is parsed '
        'THEN throws `FormatException`', () {
      expect(
        () => Item.fromJson(jsonDecode('')),
        throwsA(isA<FormatException>()),
        reason: 'should throw `FormatException`',
      );
    });
    test(
        'GIVEN a valid json is provided '
        'WHEN json is parsed '
        'THEN returns a valid `Item`', () {
      final item = Item.fromJson(jsonDecode(fakeITEM));
      expect(
        item.description,
        'DESCRIPTION',
        reason: 'parsed data should be predictable',
      );
      expect(
        item.done,
        false,
        reason: 'parsed data should be predictable',
      );
      expect(
        item.id,
        'ID',
        reason: 'parsed data should be predictable',
      );
      expect(
        item.note,
        'NOTE',
        reason: 'parsed data should be predictable',
      );
      expect(
        item.quantity,
        0,
        reason: 'parsed data should be predictable',
      );
    });
  });
}

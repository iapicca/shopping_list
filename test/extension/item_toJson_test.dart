import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_list/model/all.dart';
import 'package:shopping_list/extension/all.dart';

import '../mocks/all.dart';

void main() {
  group('`Item.toJson` test', () {
    test(
        'GIVEN a valid `json`'
        'WHEN `Item.fromJson(json).toJson` '
        'THEN output should match `json`', () {
      expect(
        Item.fromJson(jsonDecode(fakeITEM)).toJson,
        fakeITEM.replaceAll(RegExp(r'\s+'), ''),
        reason: 'items should match',
      );
    });
  });
}

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_list/model/api_config.dart';

import '../mocks/api_config.dart';

void main() {
  group('ApiConfig test', () {
    test(
        'GIVEN a INVALID json is provided '
        'WHEN json is parsed '
        'THEN throws `FormatException`', () {
      expect(
        () => ApiConfig.fromJson(jsonDecode('')),
        throwsA(isA<FormatException>()),
        reason: 'should throw `FormatException`',
      );
    });
    test(
        'GIVEN a valid json is provided '
        'WHEN json is parsed '
        'THEN returns a valid `ApiConfig`', () {
      final apiConfig = ApiConfig.fromJson(jsonDecode(fakeAPICONFIG));
      expect(
        apiConfig.endpoint,
        'ENDPOINT',
        reason: 'parsed data should be predictable',
      );
      expect(
        apiConfig.headers.entries.first.key,
        'Content-Type',
        reason: 'parsed data should be predictable',
      );
      expect(
        apiConfig.headers.entries.first.value,
        'application/json',
        reason: 'parsed data should be predictable',
      );
      expect(
        apiConfig.headers.entries.length,
        1,
        reason: 'parsed data should be predictable',
      );
    });
  });
}

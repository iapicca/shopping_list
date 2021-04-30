import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_list/domain/all.dart';
import 'package:shopping_list/model/result.dart';

class Foo {
  Foo(this.data);

  factory Foo.fromJson(Map<String, Object?> json) {
    return Foo(json['data'] as String);
  }
  final String data;
}

void main() {
  const badJson = '{"notdata": "something"}';
  const goodJson = '{"data": "something"}';

  group('`parser` test', () {
    final fooParser = parser<Foo>((json) => Foo.fromJson(json));
    test('GIVEN an invalid "json"' 'WHEN parse<T>' 'THEN returns a `Failure`',
        () {
      expect(
        fooParser(badJson),
        isA<Failure>(),
        reason: 'should return a `Failure`',
      );
    });
    test('GIVEN a valid "json"' 'WHEN parse<T>' 'THEN returns a `Failure`', () {
      final fooParser = parser<Foo>((json) => Foo.fromJson(json));
      expect(
        fooParser(goodJson),
        isA<Success>(),
        reason: 'should return a `Success`',
      );
    });
  });
}

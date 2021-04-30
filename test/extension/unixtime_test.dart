import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_list/extension/all.dart';

void main() {
  final millenimBug = DateTime(2000).toLocal();
  group('UnixToDateTimeX & DateTimeToUnixX test', () {
    test(
        'GIVEN DateTime().unixtime'
        'WHEN unixtime.toDateTime'
        'THEN returns initial DateTime', () {
      final unixtime = millenimBug.unixtime;
      expect(
        unixtime.toDateTime,
        millenimBug,
        reason: 'datetime should match initial value',
      );
    });
  });
}

/// an `extension`  that converts an `int` to `DateTime`
extension UnixToDateTimeX on int {
  /// returns a `DateTime` representative of the int's `unixtime`
  DateTime get toDateTime {
    return DateTime.utc(1970).add(Duration(milliseconds: this)).toLocal();
  }
}

/// an `extension`  that converts  `DateTime` to an `int` (unixtime)
extension DateTimeToUnixX on DateTime {
  /// returns an `int` representative of the date's `unixtime`
  int get unixtime {
    return toUtc().millisecondsSinceEpoch;
  }
}

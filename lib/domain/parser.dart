import 'dart:convert';

import '../model/all.dart';

/// a simple function that return the `Result` of
/// parsing a `json` with a given `Function`
Parse<T> parser<T>(T Function(Map<String, Object?>) parse) {
  return (String json) {
    try {
      final t = parse(jsonDecode(json));
      return Success<T>(t);
    } on Exception catch (e, s) {
      return Failure(FailureReport(e, s));
    } on TypeError catch (e) {
      return Failure(FailureReport(e, e.stackTrace));
    }
  };
}

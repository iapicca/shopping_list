import '../result.dart';

/// a `typedef` for a Function that "parse" a given json `String`
typedef Parse<T> = Result<T> Function(String);

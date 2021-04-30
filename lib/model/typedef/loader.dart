import '../result.dart';

/// a `typedef` for a Function that "loads" an asset given a `location`
typedef Loader<T> = Future<Result<T>> Function(String);

import '../../all.dart';

/// a typedef for a `CRUD` operation `update`
typedef Update<T> = Future<Result> Function(T);

import '../../all.dart';

/// a typedef for a `CRUD` operation `delete`
typedef Delete<T> = Future<Result> Function(T);

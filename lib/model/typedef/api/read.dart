import '../../all.dart';

/// a typedef for a `CRUD` operation `read`
typedef Read<T> = Future<Result<List<T>>> Function();

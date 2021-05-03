import '../../all.dart';

/// a typedef for a `CRUD` operation `create`
typedef Create<T> = Future<Result<T>> Function(T);

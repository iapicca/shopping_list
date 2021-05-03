import 'package:http/http.dart';

/// a typedef for  `http`  `delete`
typedef HttpDELETE = Future<Response> Function(Uri url,
    {Map<String, String>? headers});

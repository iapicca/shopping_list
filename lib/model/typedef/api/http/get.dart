import 'package:http/http.dart';

/// a typedef for  `http`  `get`
typedef HttpGET = Future<Response> Function(Uri url,
    {Map<String, String>? headers});

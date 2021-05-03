import 'dart:convert';
import 'package:http/http.dart';

/// a typedef for  `http`  `post`
typedef HttpPOST = Future<Response> Function(Uri url,
    {Map<String, String>? headers, Object? body, Encoding? encoding});

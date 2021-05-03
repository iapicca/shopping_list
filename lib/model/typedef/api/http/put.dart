import 'dart:convert';
import 'package:http/http.dart';

/// a typedef for  `http`  `put`
typedef HttpPUT = Future<Response> Function(Uri url,
    {Map<String, String>? headers, Object? body, Encoding? encoding});

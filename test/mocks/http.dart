import 'dart:convert';

import 'package:http/http.dart';
import 'package:stub/stub.dart';

class HttpMock {
  final postStub = nullaryStub<Response>();

  Future<Response> post(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    return postStub.stub();
  }
}

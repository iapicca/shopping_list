import 'dart:convert';

import 'package:http/http.dart';
import 'package:stub/stub.dart';

class HttpMock {
  final postStub = nullaryStub<Response>();
  final getStub = nullaryStub<Response>();
  final putStub = nullaryStub<Response>();

  Future<Response> post(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    return postStub.stub();
  }

  Future<Response> get(Uri url, {Map<String, String>? headers}) async {
    return getStub.stub();
  }

  Future<Response> put(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    return putStub.stub();
  }
}

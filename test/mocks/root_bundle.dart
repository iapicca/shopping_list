import 'package:stub/stub.dart';

class RootBundleMock {
  RootBundleMock() : stub = unaryStub<Future<String>, String>();

  final Stub<Future<String> Function(String)> stub;

  Future<String> call(String location, {bool cache = true}) {
    return stub.stub(location);
  }
}

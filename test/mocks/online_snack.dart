import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:stub/stub.dart';

class OnlineSnackMock {
  final stub = nullaryStub();
  void call(BuildContext context, ConnectivityResult connectivityResult) =>
      stub.stub();
}

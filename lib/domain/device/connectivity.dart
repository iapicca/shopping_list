import 'package:connectivity/connectivity.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// provide the status of `connectivity`
final connectivityPod = Provider<Stream<ConnectivityResult>>((ref) {
  return Connectivity().onConnectivityChanged;
});

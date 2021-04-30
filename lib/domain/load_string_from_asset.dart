import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../model/all.dart';

/// a `Provider` for `Loader<String>` that takes a given `asset` locations
final loadStringFromAsset = Provider<Loader<String>>((ref) {
  final loadString = ref.read(rootBundleLoadStringPod);
  return (String location) async {
    try {
      return Success(await loadString(location));
    } on Exception catch (e, s) {
      return Failure(FailureReport(e, s));
    }
  };
});

/// `_RootBundleLoadString` is just for readability
typedef _RootBundleLoadString = Future<String> Function(String, {bool cache});

/// `rootBundleLoadStringPod` is mostly for easy mocking
final rootBundleLoadStringPod = Provider<_RootBundleLoadString>((ref) {
  return rootBundle.loadString;
});

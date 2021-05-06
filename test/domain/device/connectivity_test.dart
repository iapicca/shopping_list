import 'package:connectivity/connectivity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_list/domain/all.dart';

void main() {
  final container = ProviderContainer(
    overrides: [
      connectivityPod.overrideWithValue(
        Stream.fromIterable([ConnectivityResult.wifi]),
      ),
    ],
  );

  group('connectivityResultPod test', () {
    test(
        'WHEN container.read'
        'THEN returns `ValueNotifier<ConnectivityResult>`', () {
      expect(
        container.read(connectivityPod),
        isA<Stream<ConnectivityResult>>(),
        reason: 'should return a `Stream<ConnectivityResult>`',
      );
    });
  });
}

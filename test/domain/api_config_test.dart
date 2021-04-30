import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_list/domain/all.dart';
import 'package:shopping_list/model/all.dart';
import '../mocks/all.dart';

void main() {
  group('`apiConfigPod` test', () {
    final rootBundleMock = RootBundleMock()
      ..stub.stub = (_) async => fakeAPICONFIG;
    final container = ProviderContainer(
      overrides: [
        rootBundleLoadStringPod
            .overrideWithProvider(Provider((ref) => rootBundleMock))
      ],
    );
    test('WHEN succeed to fetch THEN returns a `Success`', () async {
      rootBundleMock.stub.reset;
      expect(
        await container.read(apiConfigPod),
        isA<Success>(),
        reason: 'should return a `Succcess`',
      );
      expect(
        rootBundleMock.stub.count,
        1,
        reason: 'root bundle should be called once`',
      );
    });
    test(
        'GIVEN data was already fetched '
        'WHEN fetched again '
        'THEN root bundle should not be called', () async {
      rootBundleMock.stub.reset;
      expect(
        await container.read(apiConfigPod),
        isA<Success>(),
        reason: 'should return a `Succcess`',
      );
      expect(
        rootBundleMock.stub.count,
        0,
        reason: 'root bundle should NOT be called`',
      );
    });
    test('WHEN fails to fetch THEN returns a `Failure`', () async {
      rootBundleMock.stub.reset;
      rootBundleMock.stub.stub = (_) => throw Exception();
      expect(
        await container.read(apiConfigPod),
        isA<Failure>(),
        reason: 'should return a `Failure`',
      );
    });
  });
}

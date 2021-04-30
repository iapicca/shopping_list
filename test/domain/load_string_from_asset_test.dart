import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_list/domain/all.dart';
import 'package:shopping_list/model/all.dart';
import '../mocks/all.dart';

void main() {
  group('`loadStringFromAsset` test', () {
    final rootBundleMock = RootBundleMock();
    final container = ProviderContainer(
      overrides: [
        rootBundleLoadStringPod
            .overrideWithProvider(Provider((ref) => rootBundleMock))
      ],
    );
    test('WHEN throw Exception THEN returns a `Failure`', () async {
      rootBundleMock.stub.stub = (_) => throw Exception();
      final stringFromAsset = container.read(loadStringFromAsset);
      expect(
        await stringFromAsset(''),
        isA<Failure>(),
        reason: 'should return a `Failure`',
      );
    });
    test('WHEN load as String THEN returns a `Success`', () async {
      rootBundleMock.stub.stub = (_) async => 'hello';
      final stringFromAsset = container.read(loadStringFromAsset);
      expect(
        await stringFromAsset(''),
        isA<Success>(),
        reason: 'should return a `Success`',
      );
    });
    test('WHEN throws Error THEN Error flows through', () async {
      rootBundleMock.stub.stub = (_) => throw Error();
      final stringFromAsset = container.read(loadStringFromAsset);
      expect(
        () async => await stringFromAsset(''),
        throwsA(isA<Error>()),
        reason: 'should return a `Success`',
      );
    });
  });
}

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' hide delete;
import 'package:shopping_list/domain/all.dart';
import 'package:shopping_list/model/all.dart';
import 'package:stub/stub.dart';

import '../../../mocks/all.dart';

void main() {
  final item = Item.temp(description: 'description');
  final httpMock = HttpMock()..deleteStub.stub = () => Response('', 200);
  final configStub = nullaryStub<Future<Result<ApiConfig>>>()
    ..stub = () async => Success(ApiConfig.fromJson(jsonDecode(fakeAPICONFIG)));

  group('`deleteItemPod` test', () {
    test('WHEN `apiConfig` returns a `Failure` ' 'THEN returns a `Failure`',
        () async {
      configStub.stub =
          () async => const Failure<ApiConfig>(FailureReport(null, null));

      final container = ProviderContainer(
        overrides: [
          httpDeletePod
              .overrideWithProvider(Provider((ref) => httpMock.delete)),
          apiConfigPod
              .overrideWithProvider(Provider((ref) => configStub.stub()))
        ],
      );
      final update = container.read(deleteItemPod);
      expect(
        await update(item),
        isA<Failure>(),
        reason: 'should return a `Failure`',
      );
    });

    test('WHEN `http` throw Exception THEN returns a `Failure`', () async {
      configStub.stub =
          () async => Success(ApiConfig.fromJson(jsonDecode(fakeAPICONFIG)));
      httpMock.deleteStub.stub = () => throw Exception();

      final container = ProviderContainer(
        overrides: [
          httpDeletePod
              .overrideWithProvider(Provider((ref) => httpMock.delete)),
          apiConfigPod
              .overrideWithProvider(Provider((ref) => configStub.stub()))
        ],
      );
      final update = container.read(deleteItemPod);
      expect(
        await update(item),
        isA<Failure>(),
        reason: 'should return a `Failure`',
      );
    });
    test('WHEN `http` response != 200 THEN returns a `Failure`', () async {
      httpMock.deleteStub.stub = () => Response('', 404);

      final container = ProviderContainer(
        overrides: [
          httpDeletePod
              .overrideWithProvider(Provider((ref) => httpMock.delete)),
          apiConfigPod
              .overrideWithProvider(Provider((ref) => configStub.stub()))
        ],
      );
      final update = container.read(deleteItemPod);
      expect(
        await update(item),
        isA<Failure>(),
        reason: 'should return a `Failure`',
      );
    });

    test('WHEN `http` response is 200 THEN returns a `Success`', () async {
      httpMock.deleteStub.stub = () => Response('', 200);

      final container = ProviderContainer(
        overrides: [
          httpDeletePod
              .overrideWithProvider(Provider((ref) => httpMock.delete)),
          apiConfigPod
              .overrideWithProvider(Provider((ref) => configStub.stub()))
        ],
      );

      final update = container.read(deleteItemPod);
      expect(
        await update(item),
        isA<Success>(),
        reason: 'should return a `Success`',
      );
    });
  });
}

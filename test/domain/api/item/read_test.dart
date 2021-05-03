import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' show Response;
import 'package:shopping_list/domain/all.dart';
import 'package:shopping_list/model/all.dart';
import 'package:stub/stub.dart';

import '../../../mocks/all.dart';

void main() {
  final http = HttpMock()..getStub.stub = () => Response(fakeReadITEMS, 200);
  final configStub = nullaryStub<Future<Result<ApiConfig>>>()
    ..stub = () async => Success(ApiConfig.fromJson(jsonDecode(fakeAPICONFIG)));

  group('`readItemPod` test', () {
    test('WHEN `apiConfig` returns a `Failure` ' 'THEN returns a `Failure`',
        () async {
      configStub.stub =
          () async => const Failure<ApiConfig>(FailureReport(null, null));

      final container = ProviderContainer(
        overrides: [
          httpGetPod.overrideWithProvider(Provider((ref) => http.get)),
          apiConfigPod
              .overrideWithProvider(Provider((ref) => configStub.stub()))
        ],
      );
      final read = container.read(readItemPod);
      expect(
        await read(),
        isA<Failure>(),
        reason: 'should return a `Failure`',
      );
    });

    test('WHEN `http` throw Exception THEN returns a `Failure`', () async {
      configStub.stub =
          () async => Success(ApiConfig.fromJson(jsonDecode(fakeAPICONFIG)));
      http.getStub.stub = () => throw Exception();

      final container = ProviderContainer(
        overrides: [
          httpGetPod.overrideWithProvider(Provider((ref) => http.get)),
          apiConfigPod
              .overrideWithProvider(Provider((ref) => configStub.stub()))
        ],
      );
      final read = container.read(readItemPod);
      expect(
        await read(),
        isA<Failure>(),
        reason: 'should return a `Failure`',
      );
    });
    test('WHEN `http` response != 200 THEN returns a `Failure`', () async {
      http.getStub.stub = () => Response(fakeReadITEMS, 404);

      final container = ProviderContainer(
        overrides: [
          httpGetPod.overrideWithProvider(Provider((ref) => http.get)),
          apiConfigPod
              .overrideWithProvider(Provider((ref) => configStub.stub()))
        ],
      );
      final read = container.read(readItemPod);
      expect(
        await read(),
        isA<Failure>(),
        reason: 'should return a `Failure`',
      );
    });

    test('WHEN `http` response is 200 THEN returns a `Success`', () async {
      http.getStub.stub = () => Response(fakeReadITEMS, 200);

      final container = ProviderContainer(
        overrides: [
          httpGetPod.overrideWithProvider(Provider((ref) => http.get)),
          apiConfigPod
              .overrideWithProvider(Provider((ref) => configStub.stub()))
        ],
      );

      final read = container.read(readItemPod);

      expect(
        await read(),
        isA<Success>(),
        reason: 'should return a `Success`',
      );
    });

    test(
        'GIVEN response is 200'
        'WHEN fail to decode  '
        'THEN returns a `Failure`', () async {
      http.getStub.stub = () => Response('', 200);

      final container = ProviderContainer(
        overrides: [
          httpGetPod.overrideWithProvider(Provider((ref) => http.get)),
          apiConfigPod
              .overrideWithProvider(Provider((ref) => configStub.stub()))
        ],
      );
      final read = container.read(readItemPod);
      expect(
        await read(),
        isA<Failure>(),
        reason: 'should return a `Failure`',
      );
    });
  });
}

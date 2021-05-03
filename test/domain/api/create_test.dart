import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:shopping_list/domain/all.dart';
import 'package:shopping_list/model/all.dart';
import 'package:stub/stub.dart';

import '../../mocks/all.dart';

void main() {
  final item = Item.temp(description: 'description');
  final http = HttpMock()..postStub.stub = () => Response(fakeITEM, 200);
  final configStub = nullaryStub<Future<Result<ApiConfig>>>()
    ..stub = () async => Success(ApiConfig.fromJson(jsonDecode(fakeAPICONFIG)));

  group('`createItemPod` test', () {
    test('WHEN `apiConfig` returns a `Failure` ' 'THEN returns a `Failure`',
        () async {
      configStub.stub =
          () async => const Failure<ApiConfig>(FailureReport(null, null));

      final container = ProviderContainer(
        overrides: [
          httpPostPod.overrideWithProvider(Provider((ref) => http.post)),
          apiConfigPod
              .overrideWithProvider(Provider((ref) => configStub.stub()))
        ],
      );
      final create = container.read(createItemPod);
      expect(
        await create(item),
        isA<Failure>(),
        reason: 'should return a `Failure`',
      );
    });

    test('WHEN `http` throw Exception THEN returns a `Failure`', () async {
      configStub.stub =
          () async => Success(ApiConfig.fromJson(jsonDecode(fakeAPICONFIG)));
      http.postStub.stub = () => throw Exception();

      final container = ProviderContainer(
        overrides: [
          httpPostPod.overrideWithProvider(Provider((ref) => http.post)),
          apiConfigPod
              .overrideWithProvider(Provider((ref) => configStub.stub()))
        ],
      );
      final create = container.read(createItemPod);
      expect(
        await create(item),
        isA<Failure>(),
        reason: 'should return a `Failure`',
      );
    });
    test('WHEN `http` response != 200 THEN returns a `Failure`', () async {
      http.postStub.stub = () => Response(fakeITEM, 404);

      final container = ProviderContainer(
        overrides: [
          httpPostPod.overrideWithProvider(Provider((ref) => http.post)),
          apiConfigPod
              .overrideWithProvider(Provider((ref) => configStub.stub()))
        ],
      );
      final create = container.read(createItemPod);
      expect(
        await create(item),
        isA<Failure>(),
        reason: 'should return a `Failure`',
      );
    });

    test('WHEN `http` response is 200 THEN returns a `Success`', () async {
      http.postStub.stub = () => Response(fakeITEM, 200);

      final container = ProviderContainer(
        overrides: [
          httpPostPod.overrideWithProvider(Provider((ref) => http.post)),
          apiConfigPod
              .overrideWithProvider(Provider((ref) => configStub.stub()))
        ],
      );

      final create = container.read(createItemPod);
      final newItem = await create(item);
      expect(
        newItem,
        isA<Success>(),
        reason: 'should return a `Success`',
      );
    });

    test(
        'GIVEN response is 200'
        'WHEN fail to decode  '
        'THEN returns a `Failure`', () async {
      http.postStub.stub = () => Response('', 200);

      final container = ProviderContainer(
        overrides: [
          httpPostPod.overrideWithProvider(Provider((ref) => http.post)),
          apiConfigPod
              .overrideWithProvider(Provider((ref) => configStub.stub()))
        ],
      );
      final create = container.read(createItemPod);
      expect(
        await create(item),
        isA<Failure>(),
        reason: 'should return a `Failure`',
      );
    });
  });
}

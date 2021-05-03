import 'package:hooks_riverpod/hooks_riverpod.dart' hide Create;
import 'package:http/http.dart';
import '../../../model/all.dart';

import '../../all.dart';

/// returns a
final readItemPod = Provider<Read<Item>>((ref) {
  final futureConfig = ref.read(apiConfigPod);
  final httpGet = ref.read(httpGetPod);
  return () async {
    final maybeConfig = await futureConfig;
    if (maybeConfig is Failure) {
      return Failure((maybeConfig as Failure).report);
    }
    final config = (maybeConfig as Success<ApiConfig>).data;

    late final Response res;

    try {
      res = await httpGet(
        Uri.https(config.authority, config.path),
        headers: config.headers,
      );
    } on Exception catch (e, s) {
      return Failure(FailureReport(e, s));
    }
    if (res.statusCode != 200) {
      return Failure(FailureReport(res.statusCode, null));
    }
    final decodeResults = parser((json) => json['results'] as List);
    final maybeResults = decodeResults(res.body);
    if (maybeResults is Failure) {
      return Failure((maybeResults as Failure).report);
    }

    final items = <Item>[];

    for (final json in (maybeResults as Success<List>).data) {
      try {
        final item = Item.fromJson(json);

        items.add(item);
      } on Exception catch (e, s) {
        return Failure(FailureReport(e, s));
      } on TypeError catch (e) {
        return Failure(FailureReport(e, e.stackTrace));
      }
    }
    return Success(items);
  };
});

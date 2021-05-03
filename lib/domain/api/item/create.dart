import 'package:hooks_riverpod/hooks_riverpod.dart' hide Create;
import 'package:http/http.dart';
import '../../../extension/all.dart';
import '../../../model/all.dart';
import '../../all.dart';

/// returns a
final createItemPod = Provider<Create<Item>>((ref) {
  final futureConfig = ref.read(apiConfigPod);
  final post = ref.read(httpPostPod);
  return (item) async {
    final maybeConfig = await futureConfig;
    if (maybeConfig is Failure) {
      return Failure((maybeConfig as Failure).report);
    }
    final config = (maybeConfig as Success<ApiConfig>).data;

    late final Response res;

    try {
      res = await post(
        Uri.https(config.authority, config.path),
        headers: config.headers,
        body: item.toJson,
      );
    } on Exception catch (e, s) {
      return Failure(FailureReport(e, s));
    }
    if (res.statusCode != 200) {
      return Failure(FailureReport(res.statusCode, null));
    }

    final decode = parser((json) => Item.fromJson(json));
    return decode(res.body);
  };
});

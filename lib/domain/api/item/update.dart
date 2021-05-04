import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' hide put;
import '../../../extension/all.dart';
import '../../../model/all.dart';
import '../../all.dart';

/// returns a Item
final updateItemPod = Provider<Update<Item>>((ref) {
  final futureConfig = ref.read(apiConfigPod);
  final put = ref.read(httpPutPod);
  return (item) async {
    final maybeConfig = await futureConfig;
    if (maybeConfig is Failure) {
      return Failure((maybeConfig as Failure).report);
    }
    final config = (maybeConfig as Success<ApiConfig>).data;

    late final Response res;

    try {
      assert(item.id != null);
      final uri = Uri.https(config.authority, '${config.path}/${item.id!}');
      res = await put(uri, headers: config.headers, body: item.toJson);
    } on Exception catch (e, s) {
      return Failure(FailureReport(e, s));
    }

    if (res.statusCode != 200) {
      return Failure(FailureReport(res.statusCode, res.body));
    }
    return const Success(null);
  };
});

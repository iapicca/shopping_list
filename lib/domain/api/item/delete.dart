import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' hide delete;
import '../../../model/all.dart';
import '../../all.dart';

/// returns a Item
final deleteItemPod = Provider<Delete<Item>>((ref) {
  final futureConfig = ref.read(apiConfigPod);
  final delete = ref.read(httpDeletePod);
  return (item) async {
    final maybeConfig = await futureConfig;
    if (maybeConfig is Failure) {
      return Failure((maybeConfig as Failure).report);
    }
    final config = (maybeConfig as Success<ApiConfig>).data;

    late final Response res;

    try {
      assert(item.id != null);
      res = await delete(
        Uri.https(config.authority, config.path + item.id!),
        headers: config.headers,
      );
    } on Exception catch (e, s) {
      return Failure(FailureReport(e, s));
    }

    if (res.statusCode != 200) {
      return Failure(FailureReport(res.statusCode, res.body));
    }
    return const Success(null);
  };
});

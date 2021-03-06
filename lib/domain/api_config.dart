import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../model/all.dart';
import 'all.dart';

const _source = 'config/api.json';

/// a `Provider` for `Future<Result<ApiConfig>>`
final apiConfigPod = Provider<Future<Result<ApiConfig>>>((ref) async {
  final loadString = ref.read(loadStringFromAsset);
  final res = await loadString(_source);
  if (res is Failure) {
    final failure = res as Failure;
    return Failure(failure.report);
  }
  final apiConfigParser = parser((json) => ApiConfig.fromJson(json));
  final json = res as Success<String>;
  return apiConfigParser(json.data);
});

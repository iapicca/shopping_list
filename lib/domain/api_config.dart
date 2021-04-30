import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../model/all.dart';
import 'all.dart';

const _source = 'assets/api_config.json';

/// a `Provider` for `Future<Result<ApiConfig>>`
final apiConfigPod = Provider<Future<Result<ApiConfig>>>((ref) async {
  Result<ApiConfig>? _config;
  final loadString = ref.read(loadStringFromAsset);
  final res = await loadString(_source);
  if (res is Failure) {
    final failure = res as Failure;
    return Failure(failure.report);
  }
  final apiConfigParser = parser((json) => ApiConfig.fromJson(json));
  try {
    final json = res as Success<String>;
    _config = apiConfigParser(json.data);
  } on Exception catch (e, s) {
    return Failure(FailureReport(e, s));
  }
  return _config;
});

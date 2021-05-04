import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_list/model/all.dart';

/// a `Provider` for a `void Function(FailureReport)`
final onErrorPod = Provider<void Function(FailureReport report)>((ref) {
  // ignore: unnecessary_lambdas
  return (report) {
    print('############ error: ${report.error}\n'
        ' ############ stack: ${report.stackTrace}');
  };
});

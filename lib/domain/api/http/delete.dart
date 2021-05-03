import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../../model/all.dart';

/// inject the `http` post making it mockable
final httpDeletePod = Provider<HttpDELETE>((ref) => http.delete);

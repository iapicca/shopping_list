import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:shopping_list/model/typedef/api/post.dart';

/// inject the `http` post making it mockable
final httpPostPod = Provider<HttpPOST>((ref) => http.post);

/// provides the configuration for the API
class ApiConfig {
  /// a private constructor
  const ApiConfig._({
    required this.authority,
    required this.headers,
    required this.path,
  });

  /// returns `ApiConfig` from a `json`
  factory ApiConfig.fromJson(Map<String, Object?> json) {
    return ApiConfig._(
      authority: json['authority'] as String,
      headers: <String, String>{
        for (final entry in (json['headers'] as Map).entries)
          entry.key as String: entry.value as String,
      },
      path: json['path'] as String,
    );
  }

  /// the `endpoint` of the api
  final String authority;

  /// a list of `headers` of the api
  final Map<String, String> headers;

  /// the `path` of the api
  final String path;
}

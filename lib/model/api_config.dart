/// provides the configuration for the API
class ApiConfig {
  /// a private constructor
  const ApiConfig._({
    required this.endpoint,
    required this.headers,
  });

  /// returns `ApiConfig` from a `json`
  factory ApiConfig.fromJson(Map<String, Object?> json) {
    return ApiConfig._(
      endpoint: json['endpoint'] as String,
      headers: <String, String>{
        for (final entry in (json['headers'] as Map).entries)
          entry.key as String: entry.value as String,
      },
    );
  }

  /// the `endpoint` of the api
  final String endpoint;

  /// a list of `headers` of the api
  final Map<String, String> headers;
}

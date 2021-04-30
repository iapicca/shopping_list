/// provides the configuration for the API
class ApiConfig {
  /// a private constructor
  const ApiConfig._({
    required this.endpoint,
    required this.headers,
  });

  /// a factory that returns `ApiConfig` from a `json`
  factory ApiConfig(Map<String, Object?> json) {
    return ApiConfig._(
      endpoint: json['endpoint'] as String,
      headers: json['headers'] as Map<String, String>,
    );
  }

  /// the `endpoint` of the api
  final String endpoint;

  /// a list of `headers` of the api
  final Map<String, String> headers;
}

/// an abstract class that determins if an output is a `Success` or a `Failure`
/// doesn't use `Freezed` because poor `Type` support
abstract class Result<T> {
  /// a `const factory` for `Success`
  const factory Result.success(T data) = Success;

  /// a `const factory` for `Failure`
  const factory Result.failure(FailureReport data) = Failure;
}

/// an intended `Result`
class Success<T> implements Result<T> {
  /// allows a `const` constructor
  const Success(this.data);

  /// hold data of a given `type`
  final T data;
}

/// an unintended `Result`
class Failure<T> implements Result<T> {
  /// allows a `const` constructor
  const Failure(this.report);

  /// hold data of a possible `Error` or `Exception` as `FailureReport`
  final FailureReport report;
}

/// a class that holds data of a possible `Error` or `Exception`
class FailureReport {
  /// allows a `const` constructor
  const FailureReport(this.error, this.stackTrace);

  /// a simplified constructor for a `FailureReport` from `Error`
  factory FailureReport.fromError(Error e) {
    return FailureReport(e, e.stackTrace);
  }

  /// the `Error` or `Exception`
  final Object? error;

  /// the `StackTrace` of the `Error` or `Exception`
  final Object? stackTrace;
}

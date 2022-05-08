import '../network/base_api.dart';

class ErrorHelper {
  static String getLocalizedMessage(err,
      [String fallback = 'something went wrong']) {
    try {
      if (err is RequestException) {
        return err.message;
      }
      return "$err";
    } catch (err) {
      return "$fallback: $err";
    }
  }
}

class CustomException implements Exception {
  CustomException(this.message);
  final dynamic message;

  String toString() {
    Object? message = this.message;
    if (message == null) return "Something went wrong";
    return "$message";
  }
}

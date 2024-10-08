class AuthException implements Exception {
  String? message;
  int? statusCode;

  AuthException({this.message, this.statusCode});

  @override
  String toString() {
    return 'AuthException{message: $message, statusCode: $statusCode}';
  }
}

class UnknownException implements Exception {
  String? message;

  UnknownException({this.message});

  @override
  String toString() {
    return 'UnknownException{message: $message}';
  }
}

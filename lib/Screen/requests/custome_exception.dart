class CustomException implements Exception {
  final _message;
  final _prefix;

  CustomException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class SocketExceptionss extends CustomException {
  SocketExceptionss([String? message])
      : super(message, "Connection Exception: ");
}

class ConnectionTimeOut extends CustomException {
  ConnectionTimeOut([String? message]) : super(message, "ConnectionTimeOut: ");
}

class FormatExceptions extends CustomException {
  FormatExceptions([String? message]) : super(message, "FormatExceptions: ");
}

class ErrorException extends CustomException {
  ErrorException([String? message]) : super(message, " ");
}

class NotFoundExceptions extends CustomException {
  NotFoundExceptions([String? message]) : super(message, "");
}

class BadRequestException extends CustomException {
  BadRequestException([String? message])
      : super(message, "BadRequestException: ");
}

class InternalServerError extends CustomException {
  InternalServerError([String? message])
      : super(message, "InternalServerError: ");
}

class SomethingWendWrong extends CustomException {
  SomethingWendWrong([String? message])
      : super(message, ""); //"SomethingWendWrong: ");
}

class ConnectionRefused extends CustomException {
  ConnectionRefused([String? message]) : super(message, "ConnectionRefused: ");
}

class ConnectionReset extends CustomException {
  ConnectionReset([String? message]) : super(message, "ConnectionReset: ");
}

class DNSLookupFailed extends CustomException {
  DNSLookupFailed([String? message]) : super(message, "DNSLookupFailed: ");
}

class HttpConnectionClosed extends CustomException {
  HttpConnectionClosed([String? message])
      : super(message, "HttpConnectionClosed: ");
}

class HttpParserError extends CustomException {
  HttpParserError([String? message]) : super(message, "HttpParserError: ");
}

class HttpRequestFailed extends CustomException {
  HttpRequestFailed([String? message]) : super(message, "HttpRequestFailed: ");
}

class NoUsersFailure {
  final int code;
  final String message;

  NoUsersFailure(this.code, this.message);
}

class InternetFailureException {
  final int code;
  final String message;

  InternetFailureException(this.code, this.message);
}

class ServiceNotFoundException {
  final int code;
  final String message;

  ServiceNotFoundException(this.code, this.message);
}

class InvalidDataFormatException {
  final int code;
  final String message;

  InvalidDataFormatException(this.code, this.message);
}

class UncaughtError {
  final int code;
  final String message;

  UncaughtError(this.code, this.message);
}

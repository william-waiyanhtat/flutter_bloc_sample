class NoUsersFailureException {
  final int code;
  final String message;

  NoUsersFailureException(this.code, this.message);
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

class UncaughtException {
  final int code;
  final String message;

  UncaughtException(this.code, this.message);
}

enum DataError {
  AccessDenied,
  UserNotFound,
  WrongPassword,
  EmailAlreadyUsed,
  WeakPassword,
  InvalidVerificationCode,
  Unknown,
}

class DataException implements Exception {
  final String ?message;
  final String ?explanation;
  final DataError ?error;
  const DataException({this.message, this.error,this.explanation});

  String toString() => '${error.toString()}: $message';

  
}
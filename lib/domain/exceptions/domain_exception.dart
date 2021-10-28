enum DomainError {
  AccessDenied,
  UserNotFound,
  WrongPassword,
  EmailAlreadyUsed,
  WeakPassword,
  InvalidVerificationCode,
  Unknown,
  QrCodeNotActivated
}

class DomainException implements Exception {
  final String ?message;
  final String ?explanation;
  final dynamic data;
  final DomainError ?error;
  const DomainException({this.message, this.error,this.explanation,this.data});

  String toString() => '${error.toString()}: $message';

  
}
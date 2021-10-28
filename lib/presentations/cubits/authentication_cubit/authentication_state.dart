part of 'authentication_cubit.dart';

enum StatusAuthentication {
  initial,
  initial_save,
  initial_save_code,
  final_save,
  loading,
  finish,
  no_autenticado,
  autenticado,
  hay_token,
  authenticated_without_qr_code_not_activated,
  scan_code,
  encuesta,
  logout,
  welcome,
  validate_mail,
  poll
  
}

class AuthenticationState extends Equatable {
  AuthenticationState(
      {this.status = StatusAuthentication.hay_token,
      this.statusQr = StatusAuthentication.initial,
      this.verificationID = "",
      this.telefono = "",
      required this.ciudades,
      required this.ciudadesPlus,
      required this.qr,
      this.statusSocket=StatusAuthentication.initial});

  final StatusAuthentication status;
  final StatusAuthentication statusQr;
  final StatusAuthentication statusSocket;
  final String verificationID;
  final String telefono;
  final List<CityModel> ciudades;
  final List<String> ciudadesPlus;
  final QrModel qr;

  @override
  List<Object> get props =>
      [status,statusQr,statusSocket, verificationID, telefono, ciudades, ciudadesPlus, qr];

  AuthenticationState copyWith(
      {StatusAuthentication? status,
      String? verificationID,
      String? telefono,
      List<CityModel>? ciudades,
      List<String>? ciudadesPlus,
      QrModel? qr,
      StatusAuthentication? statusQr,
      StatusAuthentication? statusSocket}) {
    return AuthenticationState(
        status: status ?? this.status,
        verificationID: verificationID ?? this.verificationID,
        telefono: telefono ?? this.telefono,
        ciudades: ciudades ?? this.ciudades,
        ciudadesPlus: ciudadesPlus ?? this.ciudadesPlus,
        qr: qr ?? this.qr,
        statusQr:statusQr??this.statusQr,
        statusSocket:statusSocket??this.statusSocket);
  }
}

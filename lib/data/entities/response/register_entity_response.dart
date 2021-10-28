import 'dart:convert';

class RegisterEntityResponse {
  RegisterEntityResponse({
    this.code,
    this.mesage,
    this.user,
  });

  int? code;
  String? mesage;
  UserRER? user;

  factory RegisterEntityResponse.fromJson(String str) =>
      RegisterEntityResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegisterEntityResponse.fromMap(Map<String, dynamic> json) =>
      RegisterEntityResponse(
        code: json["code"],
        mesage: json["mesage"],
        user: UserRER.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "mesage": mesage,
        "user": user!.toMap(),
      };
}

class UserRER {
  UserRER({
    this.ciudad,
    this.usuario,
    this.correo,
    this.numeroCelular,
    this.idToken,
    this.id,
  });

  String? ciudad;
  String? usuario;
  String? correo;
  int? numeroCelular;
  String? idToken;
  int? id;

  factory UserRER.fromJson(String str) => UserRER.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserRER.fromMap(Map<String, dynamic> json) => UserRER(
        ciudad: json["ciudad"],
        usuario: json["usuario"],
        correo: json["correo"],
        numeroCelular: json["numero_celular"],
        idToken: json["id_token"],
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "ciudad": ciudad,
        "usuario": usuario,
        "correo": correo,
        "numero_celular": numeroCelular,
        "id_token": idToken,
        "id": id,
      };
}

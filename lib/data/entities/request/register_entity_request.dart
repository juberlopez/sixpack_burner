import 'dart:convert';

class RegisterEntityRequest {
    RegisterEntityRequest({
        this.ciudad,
        this.usuario,
        this.correo,
        this.numeroCelular,
        this.pass,
        this.idToken,
    });

    String ?ciudad;
    String ?usuario;
    String ?correo;
    int ?numeroCelular;
    String ?pass;
    String ?idToken;

    factory RegisterEntityRequest.fromJson(String str) => RegisterEntityRequest.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory RegisterEntityRequest.fromMap(Map<String, dynamic> json) => RegisterEntityRequest(
        ciudad: json["ciudad"],
        usuario: json["usuario"],
        correo: json["correo"],
        numeroCelular: json["numero_celular"],
        pass: json["pass"],
        idToken: json["id_token"],
    );

    Map<String, dynamic> toMap() => {
        "ciudad": ciudad,
        "usuario": usuario,
        "correo": correo,
        "numero_celular": numeroCelular,
        "pass": pass,
        "id_token": idToken,
    };
}
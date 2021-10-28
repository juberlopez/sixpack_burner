import 'dart:convert';

class LoginEntityRequest {
    LoginEntityRequest({
        this.correo,
        this.pass,
    });

    String ?correo;
    String ?pass;

    factory LoginEntityRequest.fromJson(String str) => LoginEntityRequest.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory LoginEntityRequest.fromMap(Map<String, dynamic> json) => LoginEntityRequest(
        correo: json["correo"],
        pass: json["pass"],
    );

    Map<String, dynamic> toMap() => {
        "correo": correo,
        "pass": pass,
    };
}
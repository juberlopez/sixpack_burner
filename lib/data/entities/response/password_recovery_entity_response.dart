// To parse this JSON data, do
//
//     final passwordRecoveryEntityResponse = passwordRecoveryEntityResponseFromMap(jsonString);

import 'dart:convert';

class PasswordRecoveryEntityResponse {
    PasswordRecoveryEntityResponse({
        this.message,
        this.code,
        this.status,
    });

    String ?message;
    int ?code;
    bool ?status;

    factory PasswordRecoveryEntityResponse.fromJson(String str) => PasswordRecoveryEntityResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PasswordRecoveryEntityResponse.fromMap(Map<String, dynamic> json) => PasswordRecoveryEntityResponse(
        message: json["message"],
        code: json["code"],
        status: json["status"],
    );

    Map<String, dynamic> toMap() => {
        "message": message,
        "code": code,
        "status": status,
    };
}
import 'dart:convert';

class PasswordRecoveryEntityRequest {
    PasswordRecoveryEntityRequest({
        this.email,
    });

    String ?email;

    factory PasswordRecoveryEntityRequest.fromJson(String str) => PasswordRecoveryEntityRequest.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PasswordRecoveryEntityRequest.fromMap(Map<String, dynamic> json) => PasswordRecoveryEntityRequest(
        email: json["email"],
    );

    Map<String, dynamic> toMap() => {
        "email": email,
    };
}
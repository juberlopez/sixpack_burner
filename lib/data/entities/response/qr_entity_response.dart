
import 'dart:convert';

class QrEntityResponse {
    QrEntityResponse({
        this.message,
        this.id,
        this.code,
    });

    String? message;
    int? id;
    int? code;

    factory QrEntityResponse.fromRawJson(String str) => QrEntityResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory QrEntityResponse.fromJson(Map<String, dynamic> json) => QrEntityResponse(
        message: json["message"],
        id: json["id"],
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "id": id,
        "code": code,
    };
}
import 'dart:convert';

class ResponseCodeMessageEntity {
    ResponseCodeMessageEntity({
        this.idmensaje,
        this.mensaje,
        this.codigomensaje,
        this.tipomensaje,
    });

    String ?idmensaje;
    String ?mensaje;
    String ?codigomensaje;
    String ?tipomensaje;

    factory ResponseCodeMessageEntity.fromRawJson(String str) => ResponseCodeMessageEntity.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ResponseCodeMessageEntity.fromJson(Map<String, dynamic> json) => ResponseCodeMessageEntity(
        idmensaje: json["idmensaje"],
        mensaje: json["mensaje"],
        codigomensaje: json["codigomensaje"],
        tipomensaje: json["tipomensaje"],
    );

    Map<String, dynamic> toJson() => {
        "idmensaje": idmensaje,
        "mensaje": mensaje,
        "codigomensaje": codigomensaje,
        "tipomensaje": tipomensaje,
    };
}
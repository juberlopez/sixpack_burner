

import 'dart:convert';

class MyProgressEntityResponse {
  MyProgressEntityResponse({
    this.myProgress,
  });

  List<MiProgreso>? myProgress;

  factory MyProgressEntityResponse.fromRawJson(String str) =>
      MyProgressEntityResponse.fromJson(json.decode(str));



  factory MyProgressEntityResponse.fromJson(List<dynamic> list) =>
      MyProgressEntityResponse(
        myProgress:list.isNotEmpty? list.map<MiProgreso>((x) => MiProgreso.fromJson(x)).toList():[]
      );

}

class MiProgreso {
    MiProgreso({
        this.peso,
        this.id,
        this.fecha,
        this.fotos,
    });

    int ?peso;
    int ?id;
    String ?fecha;
    Fotos ?fotos;

    factory MiProgreso.fromRawJson(String str) => MiProgreso.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MiProgreso.fromJson(Map<String, dynamic> json) => MiProgreso(
        peso: json["peso"],
        id: json["id"],
        fecha: json["fecha"],
        fotos: Fotos.fromJson(json["fotos"]),
    );

    Map<String, dynamic> toJson() => {
        "peso": peso,
        "id": id,
        "fecha": fecha,
        "fotos": fotos!.toJson(),
    };
}

class Fotos {
    Fotos({
        this.small,
        this.medium,
        this.large,
    });

    String ?small;
    String ?medium;
    String ?large;

    factory Fotos.fromRawJson(String str) => Fotos.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Fotos.fromJson(Map<String, dynamic> json) => Fotos(
        small: json["small"],
        medium: json["medium"],
        large: json["large"],
    );

    Map<String, dynamic> toJson() => {
        "small": small,
        "medium": medium,
        "large": large,
    };
}

import 'dart:convert';

class ChallengeEntityResponse {
  ChallengeEntityResponse({
    this.challenge,
  });

  List<Reto>? challenge;

  factory ChallengeEntityResponse.fromRawJson(String str) =>
      ChallengeEntityResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChallengeEntityResponse.fromJson(List<dynamic> list) =>
      ChallengeEntityResponse(
        challenge:list.isNotEmpty? list.map<Reto>((x) => Reto.fromJson(x)).toList():[]
            //List<Receta>.from(json["dietas"].map((x) => Receta.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "recipe": List<dynamic>.from(challenge!.map((x) => x.toJson())),
      };
}

// To parse this JSON data, do
//
//     final reto = retoFromJson(jsonString);



class Reto {
    Reto({
        this.id,
        this.title,
        this.image,
        this.body,
        this.fecha,
        this.data,
    });

    int ?id;
    String ?title;
    String ?image;
    String ?body;
    DateTime ?fecha;
    String ?data;

    factory Reto.fromRawJson(String str) => Reto.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Reto.fromJson(Map<String, dynamic> json) => Reto(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        body: json["body"],
        fecha: DateTime.parse(json["fecha"]),
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "body": body,
        "fecha": "${fecha!.year.toString().padLeft(4, '0')}-${fecha!.month.toString().padLeft(2, '0')}-${fecha!.day.toString().padLeft(2, '0')}",
        "data": data,
    };
}

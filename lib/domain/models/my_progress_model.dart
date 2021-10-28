import 'dart:convert';

class MyProgressModel {
    MyProgressModel({
        this.peso,
        this.id,
        this.fecha,
        this.fotos,
    });

    int ?peso;
    int ?id;
    String ?fecha;
    Photo ?fotos;

    
}

class Photo {
    Photo({
        this.small,
        this.medium,
        this.large,
    });

    String ?small;
    String ?medium;
    String ?large;

    factory Photo.fromRawJson(String str) => Photo.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Photo.fromJson(Map<String, dynamic> json) => Photo(
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
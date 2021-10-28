// To parse this JSON data, do
//
//     final recetaEntityResponse = recetaEntityResponseFromJson(jsonString);

import 'dart:convert';

class RecipeModel {
    RecipeModel({
        this.id,
        this.name,
        this.cover,
        this.category,
        this.description,
        this.sharelink,
        this.likes,
        this.favorites,
        this.isLike,
        this.isFavorite,
    });

    int ?id;
    String? name;
    String ?cover;
    String ?category;
    String ?description;
    String ?sharelink;
    int ?likes;
    int ?favorites;
    bool ?isLike;
    bool ?isFavorite;

    factory RecipeModel.fromRawJson(String str) => RecipeModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
        id: json["id"],
        name: json["name"],
        cover: json["cover"],
        category: json["category"],
        description: json["description"],
        sharelink: json["sharelink"],
        likes: json["likes"],
        favorites: json["favorites"],
        isLike: json["isLike"],
        isFavorite: json["isFavorite"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cover": cover,
        "category": category,
        "description": description,
        "sharelink": sharelink,
        "likes": likes,
        "favorites": favorites,
        "isLike": isLike,
        "isFavorite": isFavorite,
    };
}

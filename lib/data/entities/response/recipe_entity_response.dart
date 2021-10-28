import 'dart:convert';

class RecipeEntityResponse {
  RecipeEntityResponse({
    this.recipe,
  });

  List<Receta>? recipe;

  factory RecipeEntityResponse.fromRawJson(String str) =>
      RecipeEntityResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecipeEntityResponse.fromJson(List<dynamic> list) =>
      RecipeEntityResponse(
        recipe:list.isNotEmpty? list.map<Receta>((x) => Receta.fromJson(x)).toList():[]
            //List<Receta>.from(json["dietas"].map((x) => Receta.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "recipe": List<dynamic>.from(recipe!.map((x) => x.toJson())),
      };
}

class Receta {
  Receta({
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

  int? id;
  String? name;
  String? cover;
  String? category;
  String? description;
  String? sharelink;
  int? likes;
  int? favorites;
  bool? isLike;
  bool? isFavorite;

  factory Receta.fromRawJson(String str) => Receta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Receta.fromJson(Map<String, dynamic> json) => Receta(
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

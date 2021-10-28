// To parse this JSON data, do
//
//     final reto = retoFromJson(jsonString);



class ChallengeModel {
    ChallengeModel({
        this.id,
        this.title,
        this.image,
        this.body,
        this.fecha,
        this.data,
    });

    int? id;
    String? title;
    String? image;
    String? body;
    DateTime? fecha;
    String? data; 
}

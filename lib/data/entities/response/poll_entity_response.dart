

import 'dart:convert';

import 'package:sixpackburner/data/entities/response/login_entity_reponse.dart';

class PollEntityResponse {
    PollEntityResponse({
        this.dietas,
        this.info,
    });

    List<Dieta> ?dietas;
    Info ?info;

    factory PollEntityResponse.fromRawJson(String str) => PollEntityResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PollEntityResponse.fromJson(Map<String, dynamic> json) => PollEntityResponse(
        dietas: List<Dieta>.from(json["dietas"].map((x) => Dieta.fromJson(x))),
        info: Info.fromJson(json["info"]),
    );

    Map<String, dynamic> toJson() => {
        "dietas": List<dynamic>.from(dietas!.map((x) => x.toJson())),
        "info": info!.toJson(),
    };
}



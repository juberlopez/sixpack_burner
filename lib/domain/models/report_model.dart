// To parse this JSON data, do
//
//     final reportModel = reportModelFromJson(jsonString);

import 'dart:convert';

import 'package:burnet_stack/domain/models/user_model.dart';

class ReportModel {
    ReportModel({
        this.genero,
        this.panel,
        this.usuario,
        this.nutricionista,
        this.objetivo,
        this.producto,
        this.antro,
        this.vegetariano,
        this.batido,
        this.datosAntro,
    });

    String ?genero;
    PanelModel ?panel;
    UsuarioModel ?usuario;
    NutricionistaModel ?nutricionista;
    String ?objetivo;
    String ?producto;
    AntroModel ?antro;
    bool ?vegetariano;
    bool ? batido;
    DatosAntroModel ?datosAntro;

    factory ReportModel.fromRawJson(String str) => ReportModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
        genero: json["genero"],
        panel: PanelModel.fromJson(json["panel"]),
        usuario: UsuarioModel.fromJson(json["usuario"]),
        nutricionista: NutricionistaModel.fromJson(json["nutricionista"]),
        objetivo: json["objetivo"],
        producto: json["producto"],
        antro: AntroModel.fromJson(json["antro"]),
        vegetariano: json["vegetariano"],
        batido: json["vegetariano"],
        datosAntro: DatosAntroModel.fromJson(json["datos_antro"]),
    );

    Map<String, dynamic> toJson() => {
        "genero": genero,
        "panel": panel!.toJson(),
        "usuario": usuario!.toJson(),
        "nutricionista": nutricionista!.toJson(),
        "objetivo": objetivo,
        "producto": producto,
        "antro": antro!.toJson(),
        "vegetariano": vegetariano,
        "batido":batido,
        "datos_antro": datosAntro!.toJson(),
    };
}


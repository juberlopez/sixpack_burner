import 'dart:convert';

class UserModel {
    UserModel({
        this.id,
        this.usuario,
        this.correo,
        this.numeroCelular,
        this.ciudad,
        this.foto,
        this.jsonDatos,
        this.jsonDietas,
    });

    int ?id;
    String ?usuario;
    String ?correo;
    int ?numeroCelular;
    String ?ciudad;
    String ?foto;
    JsonDatosModel ?jsonDatos;
    JsonDietasModel ?jsonDietas;

    factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        usuario: json["usuario"],
        correo: json["correo"],
        numeroCelular: json["numero_celular"],
        ciudad: json["ciudad"],
        foto: json["foto"],
        jsonDatos: JsonDatosModel.fromJson(json["json_datos"]),
        jsonDietas: JsonDietasModel.fromJson(json["json_dietas"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "usuario": usuario,
        "correo": correo,
        "numero_celular": numeroCelular,
        "ciudad": ciudad,
        "foto": foto,
        "json_datos": jsonDatos!.toJson(),
        "json_dietas": jsonDietas!.toJson(),
    };
}

class JsonDatosModel {
    JsonDatosModel({
        this.usuario,
        this.antro,
        this.nutricionista,
        this.panel,
        this.objetivo,
        this.genero,
        this.vegetariano,
        this.datosAntro,
        this.producto,
        this.batido,
    });

    UsuarioModel ?usuario;
    AntroModel ?antro;
    NutricionistaModel ?nutricionista;
    PanelModel ?panel;
    String ?objetivo;
    String ?genero;
    bool ?vegetariano;
    DatosAntroModel ?datosAntro;
    String ?producto;
    bool ?batido;

    factory JsonDatosModel.fromRawJson(String str) => JsonDatosModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory JsonDatosModel.fromJson(Map<String, dynamic> json) => JsonDatosModel(
        usuario: UsuarioModel.fromJson(json["usuario"]),
        antro: AntroModel.fromJson(json["antro"]),
        nutricionista: NutricionistaModel.fromJson(json["nutricionista"]),
        panel: PanelModel.fromJson(json["panel"]),
        objetivo: json["objetivo"],
        genero: json["genero"],
        vegetariano: json["vegetariano"],
        datosAntro: DatosAntroModel.fromJson(json["datos_antro"]),
        producto: json["producto"],
        batido: json["batido"],
    );

    Map<String, dynamic> toJson() => {
        "usuario": usuario!.toJson(),
        "antro": antro!.toJson(),
        "nutricionista": nutricionista!.toJson(),
        "panel": panel!.toJson(),
        "objetivo": objetivo,
        "genero": genero,
        "vegetariano": vegetariano,
        "datos_antro": datosAntro!.toJson(),
        "producto": producto,
        "batido": batido,
    };
}

class AntroModel {
    AntroModel({
        this.aumento,
        this.kgmuscle,
        this.calorias,
    });

    int ?aumento;
    double ?kgmuscle;
    int ?calorias;

    factory AntroModel.fromRawJson(String str) => AntroModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AntroModel.fromJson(Map<String, dynamic> json) => AntroModel(
        aumento: json["aumento"],
        kgmuscle: json["kgmuscle"]is double?json["kgmuscle"]:json["kgmuscle"].toDouble(),
        calorias: json["calorias"],
    );

    Map<String, dynamic> toJson() => {
        "aumento": aumento,
        "kgmuscle": kgmuscle,
        "calorias": calorias,
    };
}

class DatosAntroModel {
    DatosAntroModel({
        this.peso,
        this.estatura,
        this.frecuenciaEntreno,
        this.edad,
        this.porcentajeGrasa,
        this.pesoOseo,
        this.pesoResidual,
        this.porcentajeResidual,
        this.pesoGrasa,
        this.porcentajeMuscle,
        this.pesoMuscle,
        this.porcentajeOseo,
        this.imc,
    });

    String ?peso;
    int ?estatura;
    String ?frecuenciaEntreno;
    String ?edad;
    int ?porcentajeGrasa;
    double ?pesoOseo;
    double ?pesoResidual;
    double ?porcentajeResidual;
    double ?pesoGrasa;
    double ?porcentajeMuscle;
    double ?pesoMuscle;
    double ?porcentajeOseo;
    double ?imc;

    factory DatosAntroModel.fromRawJson(String str) => DatosAntroModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DatosAntroModel.fromJson(Map<String, dynamic> json) => DatosAntroModel(
        peso: json["peso"],
        estatura: json["estatura"],
        frecuenciaEntreno: json["frecuencia_entreno"],
        edad: json["edad"],
        porcentajeGrasa: json["porcentaje_grasa"],
        pesoOseo: json["peso_oseo"].toDouble(),
        pesoResidual: json["peso_residual"].toDouble(),
        porcentajeResidual: json["porcentaje_residual"].toDouble(),
        pesoGrasa: json["peso_grasa"].toDouble(),
        porcentajeMuscle: json["porcentaje_muscle"].toDouble(),
        pesoMuscle: json["peso_muscle"].toDouble(),
        porcentajeOseo: json["porcentaje_oseo"].toDouble(),
        imc: json["imc"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "peso": peso,
        "estatura": estatura,
        "frecuencia_entreno": frecuenciaEntreno,
        "edad": edad,
        "porcentaje_grasa": porcentajeGrasa,
        "peso_oseo": pesoOseo,
        "peso_residual": pesoResidual,
        "porcentaje_residual": porcentajeResidual,
        "peso_grasa": pesoGrasa,
        "porcentaje_muscle": porcentajeMuscle,
        "peso_muscle": pesoMuscle,
        "porcentaje_oseo": porcentajeOseo,
        "imc": imc,
    };
}

class NutricionistaModel {
    NutricionistaModel({
        this.idUsuario,
        this.nombres,
        this.rol,
    });

    int ?idUsuario;
    String ?nombres;
    String ?rol;

    factory NutricionistaModel.fromRawJson(String str) => NutricionistaModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory NutricionistaModel.fromJson(Map<String, dynamic> json) => NutricionistaModel(
        idUsuario: json["id_usuario"],
        nombres: json["nombres"],
        rol: json["rol"],
    );

    Map<String, dynamic> toJson() => {
        "id_usuario": idUsuario,
        "nombres": nombres,
        "rol": rol,
    };
}

class PanelModel {
    PanelModel({
        this.minutosEntreno,
        this.horaLevantarse,
        this.horaDesayuno,
        this.horaEntreno,
        this.horaAlmuerzo,
        this.horaCena,
        this.horaDormir,
    });

    int ?minutosEntreno;
    String ?horaLevantarse;
    String ?horaDesayuno;
    String ?horaEntreno;
    String ?horaAlmuerzo;
    String ?horaCena;
    String ?horaDormir;

    factory PanelModel.fromRawJson(String str) => PanelModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PanelModel.fromJson(Map<String, dynamic> json) => PanelModel(
        minutosEntreno: json["MinutosEntreno"],
        horaLevantarse: json["Hora_levantarse"],
        horaDesayuno: json["Hora_DESAYUNO"],
        horaEntreno: json["Hora_Entreno"],
        horaAlmuerzo: json["Hora_almuerzo"],
        horaCena: json["Hora_cena"],
        horaDormir: json["Hora_dormir"],
    );

    Map<String, dynamic> toJson() => {
        "MinutosEntreno": minutosEntreno,
        "Hora_levantarse": horaLevantarse,
        "Hora_DESAYUNO": horaDesayuno,
        "Hora_Entreno": horaEntreno,
        "Hora_almuerzo": horaAlmuerzo,
        "Hora_cena": horaCena,
        "Hora_dormir": horaDormir,
    };
}

class UsuarioModel {
    UsuarioModel({
        this.idUsuario,
        this.nombres,
    });

    int ?idUsuario;
    String ?nombres;

    factory UsuarioModel.fromRawJson(String str) => UsuarioModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        idUsuario: json["id_usuario"],
        nombres: json["nombres"],
    );

    Map<String, dynamic> toJson() => {
        "id_usuario": idUsuario,
        "nombres": nombres,
    };
}

class JsonDietasModel {
    JsonDietasModel({
        this.dietas,
        this.info,
    });

    List<DietaModel> ?dietas;
    InfoModel ?info;

    factory JsonDietasModel.fromRawJson(String str) => JsonDietasModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory JsonDietasModel.fromJson(Map<String, dynamic> json) => JsonDietasModel(
        dietas: List<DietaModel>.from(json["dietas"].map((x) => DietaModel.fromJson(x))),
        info: InfoModel.fromJson(json["info"]),
    );

    Map<String, dynamic> toJson() => {
        "dietas": List<dynamic>.from(dietas!.map((x) => x.toJson())),
        "info": info!.toJson(),
    };
}

class DietaModel {
    DietaModel({
        this.menu,
        this.alimentos,
    });

    int ?menu;
    List<AlimentoModel> ?alimentos;

    factory DietaModel.fromRawJson(String str) => DietaModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DietaModel.fromJson(Map<String, dynamic> json) => DietaModel(
        menu: json["menu"],
        alimentos: List<AlimentoModel>.from(json["alimentos"].map((x) => AlimentoModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "menu": menu,
        "alimentos": List<dynamic>.from(alimentos!.map((x) => x.toJson())),
    };
}

class AlimentoModel {
    AlimentoModel({
        this.proteina,
        this.chos,
        this.grasa,
        this.calorias,
        this.cantidad,
        this.cantidadMin,
        this.cantidadMax,
        this.objetivo,
        this.clave,
        this.menu,
        this.comida,
        this.producto,
        this.detalle,
        this.alimento,
        this.hora,
        this.idDetalle,
        this.idMaestro,
        this.idTabla,
    });

    double ?proteina;
    double ?chos;
    double ?grasa;
    double ?calorias;
    double ?cantidad;
    double ?cantidadMin;
    double ?cantidadMax;
    String ?objetivo;
    String ?clave;
    String ?menu;
    String ?comida;
    String ?producto;
    String ?detalle;
    String ?alimento;
    int ?hora;
    int ?idDetalle;
    int ?idMaestro;
    int ?idTabla;

    factory AlimentoModel.fromRawJson(String str) => AlimentoModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AlimentoModel.fromJson(Map<String, dynamic> json) => AlimentoModel(
        proteina: json["proteina"]is double?json["proteina"]:json["proteina"].toDouble(),
        chos: json["chos"]is double?json["chos"]:json["chos"].toDouble(),
        grasa: json["grasa"]is double?json["grasa"]:json["grasa"].toDouble(),
        calorias: json["calorias"]is double?json["calorias"]:json["calorias"].toDouble(),
        cantidad: json["cantidad"]is double?json["cantidad"]:json["cantidad"].toDouble(),
        cantidadMin: json["cantidad_min"]is double?json["cantidad_min"]:json["cantidad_min"].toDouble(),
        cantidadMax: json["cantidad_max"]is double?json["cantidad_max"]:json["cantidad_max"].toDouble(),
        objetivo: json["objetivo"],
        clave: json["clave"],
        menu: json["menu"],
        comida: json["comida"],
        producto: json["producto"],
        detalle: json["detalle"],
        alimento: json["alimento"],
        hora: json["hora"],
        idDetalle: json["id_detalle"],
        idMaestro: json["id_maestro"],
        idTabla: json["id_tabla"],
    );

    Map<String, dynamic> toJson() => {
        "proteina": proteina,
        "chos": chos,
        "grasa": grasa,
        "calorias": calorias,
        "cantidad": cantidad,
        "cantidad_min": cantidadMin,
        "cantidad_max": cantidadMax,
        "objetivo": objetivo,
        "clave": clave,
        "menu": menu,
        "comida": comida,
        "producto": producto,
        "detalle": detalle,
        "alimento": alimento,
        "hora": hora,
        "id_detalle": idDetalle,
        "id_maestro": idMaestro,
        "id_tabla": idTabla,
    };
}

class InfoModel {
    InfoModel({
        this.caloriasDieta,
        this.chos,
        this.proteina,
        this.grasa,
    });

    int ?caloriasDieta;
    int ?chos;
    int ?proteina;
    int ?grasa;

    factory InfoModel.fromRawJson(String str) => InfoModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory InfoModel.fromJson(Map<String, dynamic> json) => InfoModel(
        caloriasDieta: json["calorias_dieta"],
        chos: json["chos"],
        proteina: json["proteina"],
        grasa: json["grasa"],
    );

    Map<String, dynamic> toJson() => {
        "calorias_dieta": caloriasDieta,
        "chos": chos,
        "proteina": proteina,
        "grasa": grasa,
    };
}

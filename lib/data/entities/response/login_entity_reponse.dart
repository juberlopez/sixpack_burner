import 'dart:convert';

/*class LoginEntityResponse {
    LoginEntityResponse({
        this.user,
        this.state,
    });

    UserEr ?user;
    String ?state;

    factory LoginEntityResponse.fromJson(String str) => LoginEntityResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory LoginEntityResponse.fromMap(Map<String, dynamic> json) => LoginEntityResponse(
        user: UserEr.fromMap(json["user"]),
        state: json["state"],
    );

    Map<String, dynamic> toMap() => {
        "user": user!.toMap(),
        "state": state,
    };
}

class UserEr {
    UserEr({
        this.id,
        this.usuario,
        this.correo,
        this.numeroCelular,
        this.ciudad,
        this.foto,
    });

    int ?id;
    String ?usuario;
    String ?correo;
    int ?numeroCelular;
    String ?ciudad;
    String ?foto;

    factory UserEr.fromJson(String str) => UserEr.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UserEr.fromMap(Map<String, dynamic> json) => UserEr(
        id: json["id"],
        usuario: json["usuario"],
        correo: json["correo"],
        numeroCelular: json["numero_celular"],
        ciudad: json["ciudad"],
        foto: json["foto"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "usuario": usuario,
        "correo": correo,
        "numero_celular": numeroCelular,
        "ciudad": ciudad,
        "foto": foto,
    };
}*/




// To parse this JSON data, do
//
//     final loginEntityResponse = loginEntityResponseFromJson(jsonString);



class LoginEntityResponse {
    LoginEntityResponse({
        this.user,
        this.state,
    });

    User ?user;
    String ?state;

    factory LoginEntityResponse.fromRawJson(String str) => LoginEntityResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LoginEntityResponse.fromJson(Map<String, dynamic> json) => LoginEntityResponse(
        user: User.fromJson(json["user"]),
        state: json["state"],
    );

    Map<String, dynamic> toJson() => {
        "user": user!.toJson(),
        "state": state,
    };
}

class User {
    User({
        this.id =0,
        this.usuario="",
        this.correo="",
        this.numeroCelular=1,
        this.ciudad="",
        this.foto="",
        this.jsonDatos,
        this.jsonDietas,
    });

    int ?id;
    String ?usuario;
    String ?correo;
    int ?numeroCelular;
    String ?ciudad;
    String ?foto;
    JsonDatos ?jsonDatos;
    JsonDietas ?jsonDietas;

    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        usuario: json["usuario"],
        correo: json["correo"],
        numeroCelular: json["numero_celular"],
        ciudad: json["ciudad"],
        foto: json["foto"],
        jsonDatos:json["json_datos"]!= null? JsonDatos.fromJson(json["json_datos"]):JsonDatos(),
        jsonDietas:json["json_dietas"]!= null? JsonDietas.fromJson(json["json_dietas"]):JsonDietas(),
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

class JsonDatos {
    JsonDatos({
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

    Usuario ?usuario;
    Antro ?antro;
    Nutricionista ?nutricionista;
    Panel ?panel;
    String ?objetivo;
    String ?genero;
    bool ?vegetariano;
    DatosAntro ?datosAntro;
    String ?producto;
    bool ?batido;

    factory JsonDatos.fromRawJson(String str) => JsonDatos.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory JsonDatos.fromJson(Map<String, dynamic> json) => JsonDatos(
        usuario: Usuario.fromJson(json["usuario"]),
        antro: Antro.fromJson(json["antro"]),
        nutricionista: Nutricionista.fromJson(json["nutricionista"]),
        panel: Panel.fromJson(json["panel"]),
        objetivo: json["objetivo"],
        genero: json["genero"],
        vegetariano: json["vegetariano"],
        datosAntro: DatosAntro.fromJson(json["datos_antro"]),
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

class Antro {
    Antro({
        this.aumento,
        this.kgmuscle,
        this.calorias,
    });

    int ?aumento;
    double ?kgmuscle;
    int ?calorias;

    factory Antro.fromRawJson(String str) => Antro.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Antro.fromJson(Map<String, dynamic> json) => Antro(
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

class DatosAntro {
    DatosAntro({
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

    factory DatosAntro.fromRawJson(String str) => DatosAntro.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DatosAntro.fromJson(Map<String, dynamic> json) => DatosAntro(
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

class Nutricionista {
    Nutricionista({
        this.idUsuario,
        this.nombres,
        this.rol,
    });

    int ?idUsuario;
    String ?nombres;
    String ?rol;

    factory Nutricionista.fromRawJson(String str) => Nutricionista.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Nutricionista.fromJson(Map<String, dynamic> json) => Nutricionista(
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

class Panel {
    Panel({
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

    factory Panel.fromRawJson(String str) => Panel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Panel.fromJson(Map<String, dynamic> json) => Panel(
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

class Usuario {
    Usuario({
        this.idUsuario,
        this.nombres,
    });

    int ?idUsuario;
    String ?nombres;

    factory Usuario.fromRawJson(String str) => Usuario.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        idUsuario: json["id_usuario"],
        nombres: json["nombres"],
    );

    Map<String, dynamic> toJson() => {
        "id_usuario": idUsuario,
        "nombres": nombres,
    };
}

class JsonDietas {
    JsonDietas({
        this.dietas,
        this.info,
    });

    List<Dieta> ?dietas;
    Info ?info;

    factory JsonDietas.fromRawJson(String str) => JsonDietas.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory JsonDietas.fromJson(Map<String, dynamic> json) => JsonDietas(
        dietas: List<Dieta>.from(json["dietas"].map((x) => Dieta.fromJson(x))),
        info: Info.fromJson(json["info"]),
    );

    Map<String, dynamic> toJson() => {
        "dietas": List<dynamic>.from(dietas!.map((x) => x.toJson())),
        "info": info!.toJson(),
    };
}

class Dieta {
    Dieta({
        this.menu,
        this.alimentos,
    });

    int ?menu;
    List<Alimento> ?alimentos;

    factory Dieta.fromRawJson(String str) => Dieta.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Dieta.fromJson(Map<String, dynamic> json) => Dieta(
        menu: json["menu"],
        alimentos: List<Alimento>.from(json["alimentos"].map((x) => Alimento.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "menu": menu,
        "alimentos": List<dynamic>.from(alimentos!.map((x) => x.toJson())),
    };
}

class Alimento {
    Alimento({
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

    factory Alimento.fromRawJson(String str) => Alimento.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Alimento.fromJson(Map<String, dynamic> json) => Alimento(
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

class Info {
    Info({
        this.caloriasDieta,
        this.chos,
        this.proteina,
        this.grasa,
    });

    int ?caloriasDieta;
    int ?chos;
    int ?proteina;
    int ?grasa;

    factory Info.fromRawJson(String str) => Info.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Info.fromJson(Map<String, dynamic> json) => Info(
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

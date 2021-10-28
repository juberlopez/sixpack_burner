import 'dart:convert';

class UserPlusModel {
    UserPlusModel({
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
    

    factory UserPlusModel.fromRawJson(String str) => UserPlusModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserPlusModel.fromJson(Map<String, dynamic> json) => UserPlusModel(
        id: json["id"],
        usuario: json["usuario"],
        correo: json["correo"],
        numeroCelular: json["numero_celular"],
        ciudad: json["ciudad"],
        foto: json["foto"],
       
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "usuario": usuario,
        "correo": correo,
        "numero_celular": numeroCelular,
        "ciudad": ciudad,
        "foto": foto,
        
    };
}


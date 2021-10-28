part of 'poll_cubit.dart';

enum StatusPoll {
  initial,
  initial_save,
  initial_save_code,
  final_save,
  loading,
  finish,
  no_autenticado,
  autenticado,
  hay_token
}

class PollState extends Equatable {
  PollState(
      {this.status = StatusPoll.initial,
      this.peso = "",
      this.edad = "",
      this.genero = "",
      this.altura = "",
      this.nivelActividadFisica = "",
      this.tiempoEntreno = "",
      this.vegetariano = "",
      this.idCardBody = "0",
      required this.body,
      this.idCardMuneca = "0",
      required this.muneca,
      this.horaDespierta = "",
      this.horaEntrena = "",
      this.horaDesayuno = "",
      this.horaAlmuerzo = "",
      this.horaCena = "",
      this.producto = "",
      this.notification = false,
      this.totalCalorias = 0,
      this.totalProteinas = 0,
      this.totalCarbohidratos = 0,
      this.totalGrasas = 0});

  final StatusPoll status;
  final String peso;
  final String edad;
  final String genero;
  final String altura;
  final String nivelActividadFisica;
  final String tiempoEntreno;
  final String vegetariano;
  final String idCardBody;
  final BodyModel body;
  final String idCardMuneca;
  final MunecaModel muneca;
  final String horaDespierta;
  final String horaEntrena;
  final String horaDesayuno;
  final String horaAlmuerzo;
  final String horaCena;
  final String producto;
  final bool notification;
  final int totalCalorias;
  final int totalProteinas;
  final int totalCarbohidratos;
  final int totalGrasas;

  @override
  List<Object> get props => [
        status,
        peso,
        edad,
        genero,
        altura,
        nivelActividadFisica,
        tiempoEntreno,
        vegetariano,
        idCardBody,
        body,
        idCardMuneca,
        muneca,
        horaDespierta,
        horaEntrena,
        horaDesayuno,
        horaAlmuerzo,
        horaCena,
        producto,
        notification,
        totalCalorias,
        totalProteinas,
        totalCarbohidratos,
        totalGrasas
      ];

  PollState copyWith(
      {StatusPoll? status,
      String? peso,
      String? edad,
      String? genero,
      String? altura,
      String? nivelActividadFisica,
      String? tiempoEntreno,
      String? vegetariano,
      String? idCardBody,
      BodyModel? body,
      String? idCardMuneca,
      MunecaModel? muneca,
      String? horaDespierta,
      String? horaEntrena,
      String? horaDesayuno,
      String? horaAlmuerzo,
      String? horaCena,
      String? producto,
      bool? notification,
      int? totalCalorias,
      int? totalProteinas,
      int? totalCarbohidratos,
      int? totalGrasas}) {
    return PollState(
        status: status ?? this.status,
        peso: peso ?? this.peso,
        edad: edad ?? this.edad,
        genero: genero ?? this.genero,
        altura: altura ?? this.altura,
        nivelActividadFisica: nivelActividadFisica ?? this.nivelActividadFisica,
        tiempoEntreno: tiempoEntreno ?? this.tiempoEntreno,
        vegetariano: vegetariano ?? this.vegetariano,
        idCardBody: idCardBody ?? this.idCardBody,
        body: body ?? this.body,
        idCardMuneca: idCardMuneca ?? this.idCardMuneca,
        muneca: muneca ?? this.muneca,
        horaDespierta: horaDespierta ?? this.horaDespierta,
        horaEntrena: horaEntrena ?? this.horaEntrena,
        horaDesayuno: horaDesayuno ?? this.horaDesayuno,
        horaAlmuerzo: horaAlmuerzo ?? this.horaAlmuerzo,
        horaCena: horaCena ?? this.horaCena,
        producto: producto ?? this.producto,
        notification: notification ?? this.notification,
        totalCalorias: totalCalorias ?? this.totalCalorias,
        totalProteinas: totalProteinas ?? this.totalProteinas,
        totalCarbohidratos: totalCarbohidratos ?? this.totalCarbohidratos,
        totalGrasas: totalGrasas ?? this.totalGrasas);
  }
}

/*
final double totalCalorias;
  final double totalProteinas;
  final double totalCarbohidratos;
  final double totalGrasas;*/

/*
 double? totalCalorias,
      double? totalProteinas,
      double? totalCarbohidratos,
      double? totalGrasas*/

/*
totalCalorias: totalCalorias ?? this.totalCalorias,
        totalProteinas: totalProteinas ?? this.totalProteinas,
        totalCarbohidratos: totalCarbohidratos ?? this.totalCarbohidratos,
        totalGrasas: totalGrasas ?? this.totalGrasas
        */

/*

this.totalCalorias = 0.0,
      this.totalProteinas = 0.0,
      this.totalCarbohidratos = 0.0,
      this.totalGrasas = 0.0*/
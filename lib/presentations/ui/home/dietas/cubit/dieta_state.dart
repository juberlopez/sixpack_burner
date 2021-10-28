part of 'dieta_cubit.dart';

enum StatusDieta {
  initial,
  initial_save,
  initial_save_code,
  final_save,
  loading,
  finish,
  no_autenticado,
  autenticado,
  hay_token,
  authenticated_without_qr_code_not_activated,
  scan_code
}

class DietaState extends Equatable {
  DietaState(
      {this.status = StatusDieta.initial,
      required this.listaDietas,
      required this.info,
      required this.dieta,
      this.totalCalorias = 0,
      this.totalCarbohidratos = 0,
      this.totalProteinas = 0,
      this.totalGrasas = 0,
      this.menu =1,
      required this.comidas,
      this.notification=false});

  final StatusDieta status;
  final List<DietaModel> listaDietas;
  final InfoModel info;
  final DietaModel dieta;
  final double totalCalorias;
  final double totalProteinas;
  final double totalCarbohidratos;
  final double totalGrasas;
  final int menu;
  final Map<String?, List<AlimentoModel>> comidas;
  final bool notification;

  @override
  List<Object> get props => [
        status,
        listaDietas,
        info,
        dieta,
        totalCalorias,
        totalCarbohidratos,
        totalProteinas,
        totalGrasas,
        menu,
        comidas,
        notification
      ];

  DietaState copyWith(
      {StatusDieta? status,
      List<DietaModel>? listaDietas,
      InfoModel? info,
      DietaModel? dieta,
      double? totalCalorias,
      double? totalProteinas,
      double? totalCarbohidratos,
      double? totalGrasas,
      int? menu,
      Map<String?, List<AlimentoModel>>? comidas,
      bool? notification}) {
    return DietaState(
        status: status ?? this.status,
        listaDietas: listaDietas ?? this.listaDietas,
        info: info ?? this.info,
        dieta: dieta ?? this.dieta,
        totalCalorias:totalCalorias??this.totalCalorias,
        totalCarbohidratos: totalCarbohidratos??this.totalCarbohidratos,
        totalProteinas: totalProteinas??this.totalProteinas,
        totalGrasas: totalGrasas??this.totalGrasas,
        menu:menu??this.menu,
        comidas:comidas??this.comidas,
        notification:notification??this.notification
        );
  }
}

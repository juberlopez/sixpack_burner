part of 'recetas_cubit.dart';

enum StatusRecetas {
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

class RecetasState extends Equatable {
  RecetasState(
      {this.status = StatusRecetas.initial,
      required this.listaRecetas,
     });

  final StatusRecetas status;
  final List<RecipeModel> listaRecetas;
  

  @override
  List<Object> get props => [
        status,
        listaRecetas,
        
      ];

  RecetasState copyWith(
      {StatusRecetas? status,
      List<RecipeModel>? listaRecetas,
      }) {
    return RecetasState(
        status: status ?? this.status,
        listaRecetas:listaRecetas?? this.listaRecetas,
        
        );
  }
}

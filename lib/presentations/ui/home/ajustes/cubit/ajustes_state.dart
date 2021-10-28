part of 'ajustes_cubit.dart';

enum StatusAjustes {
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

class AjustesState extends Equatable {
  AjustesState(
      {this.status = StatusAjustes.initial,
      required this.listaRetos,
     });

  final StatusAjustes status;
  final List<ChallengeModel> listaRetos;
  

  @override
  List<Object> get props => [
        status,
        listaRetos,
        
      ];

  AjustesState copyWith(
      {StatusAjustes? status,
      List<ChallengeModel>? listaRetos,
      }) {
    return AjustesState(
        status: status ?? this.status,
        listaRetos:listaRetos?? this.listaRetos,
        
        );
  }
}

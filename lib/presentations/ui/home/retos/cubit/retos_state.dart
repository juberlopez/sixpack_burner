part of 'retos_cubit.dart';

enum StatusRetos {
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

class RetosState extends Equatable {
  RetosState(
      {this.status = StatusRetos.initial,
      required this.listaRetos,
     });

  final StatusRetos status;
  final List<ChallengeModel> listaRetos;
  

  @override
  List<Object> get props => [
        status,
        listaRetos,
        
      ];

  RetosState copyWith(
      {StatusRetos? status,
      List<ChallengeModel>? listaRetos,
      }) {
    return RetosState(
        status: status ?? this.status,
        listaRetos:listaRetos?? this.listaRetos,
        
        );
  }
}

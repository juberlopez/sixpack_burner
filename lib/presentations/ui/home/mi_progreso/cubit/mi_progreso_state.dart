part of 'mi_progreso_cubit.dart';

enum StatusMiprogreso {
  initial,

  loading,
  finish,
  
}

class MiProgresoState extends Equatable {
  MiProgresoState(
      {this.status = StatusMiprogreso.initial,
      required this.listaProgresos,
      required this.imagen,
      this.sizeListaprogreso=0
     });

  final StatusMiprogreso status;
  final List<MyProgressModel> listaProgresos;
  final int sizeListaprogreso;
  final String imagen;
  

  @override
  List<Object> get props => [
        status,
        listaProgresos,
        imagen,
        sizeListaprogreso
        
      ];

  MiProgresoState copyWith(
      {StatusMiprogreso? status,
      List<MyProgressModel>? listaProgresos,
      String? imagen,
      int? sizeListaprogreso
      }) {
    return MiProgresoState(
        status: status ?? this.status,
        listaProgresos:listaProgresos??this.listaProgresos,
        imagen:imagen??this.imagen,
        sizeListaprogreso:sizeListaprogreso??this.sizeListaprogreso
        );
  }
}

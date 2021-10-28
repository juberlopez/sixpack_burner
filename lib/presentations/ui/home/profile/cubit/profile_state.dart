part of 'profile_cubit.dart';

enum StatusProfile {
  initial,
  loading,
  finish,
  
}

class ProfileState extends Equatable {
  ProfileState(
      {this.status = StatusProfile.initial,
      required this.listaProgresos,
      required this.imagen,
      required this.user,
      required this.report
     });

  final StatusProfile status;
  final List<MyProgressModel> listaProgresos;
  final String imagen;
  final UserPlusModel user;
  final ReportModel report;
  

  @override
  List<Object> get props => [
        status,
        listaProgresos,
        imagen,
        user,
        report
      ];

  ProfileState copyWith(
      {StatusProfile? status,
      List<MyProgressModel>? listaProgresos,
      String? imagen,
      UserPlusModel? user,
      ReportModel? report
      }) {
    return ProfileState(
        status: status ?? this.status,
        listaProgresos:listaProgresos??this.listaProgresos,
        imagen:imagen??this.imagen,
        user:user??this.user,
        report:report??this.report
        );
  }
}

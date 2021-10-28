part of 'welcome_cubit.dart';



enum StatusWelcome { initial, initial_save,initial_save_code, final_save, loading, finish,no_autenticado,autenticado,hay_token }

class WelcomeState extends Equatable {
  WelcomeState(
      {this.status = StatusWelcome.initial,
      this.verificationID="",
      this.telefono="",
      required this.listBanner
      });

  final StatusWelcome status;
  final String verificationID;
  final String telefono;
  final List<WelcomeBannerModel> listBanner;
  

  @override
  List<Object> get props => [
        status,
        verificationID,
        telefono,
        listBanner
        
      ];

  WelcomeState copyWith(
      {StatusWelcome? status,
      String ?verificationID,
      String? telefono,
      List<WelcomeBannerModel>? listBanner
      }) {
    return WelcomeState(
        status: status ?? this.status,
        verificationID:verificationID??this.verificationID,
        telefono:telefono??this.telefono,
        listBanner:listBanner??this.listBanner
        );
  }
}


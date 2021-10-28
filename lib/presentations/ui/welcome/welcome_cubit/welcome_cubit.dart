import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:burnet_stack/device/device.dart';
import 'package:burnet_stack/domain/domain.dart';
import 'package:burnet_stack/presentations/services/screen_messages_service.dart';
import 'package:equatable/equatable.dart';



part 'welcome_state.dart';


class WelcomeCubit extends Cubit<WelcomeState> {
  WelcomeCubit() : super(WelcomeState(listBanner: []));

 

  Future<void> init() async {

   List<WelcomeBannerModel> listBanner=[];

   listBanner.add(WelcomeBannerModel(id: "",title: "",description: "¿Eres nuevo en el reto? ¡Únete ahora al reto que cambiará tu vida! Por primera vez ganarás premios por lograr el cuerpo que siempre has soñado"));
   listBanner.add(WelcomeBannerModel(id: "",title: "PREMIOS PARA LOS GANADORES DEL RETO",description: "1 Viaje a Cartagena para 2 personas con todos los gastos pagos, 1 Gimnasio completo para entrenar en casa, Kits de Suplementación Megaplex"));
   listBanner.add(WelcomeBannerModel(id: "",title: "ASI LO LOGRAREMOS",description: "Armaremos tu plan nutricional personalizado con conteo de calorías, preteína, grasas y carbohidratos. Armaremos tu menú con tus requerimientos nutricionales"));

    emit(state.copyWith(
      listBanner: listBanner,
    ));
  }

  Future<void> signInwithEmail(String email, String clave) async {

    emit(state.copyWith(
      status: StatusWelcome.loading,
    ));

   /* try {
     

      final respuesta = await _usuariosRepository.getUsuario(
          idUsuario: userCredential.user!.uid);

      respuesta.fold((e) {
        ScreenMessagesService().toast(e.message.toString());
        emit(state.copyWith(status: StatusAuthentication.no_autenticado));
      }, (response) {
        //ScreenMessages().toast("No existe Usuario");
        emit(state.copyWith(status: StatusAuthentication.autenticado));
      });
    } 
     catch (e) {
      print(e);
      ScreenMessagesService()
            .toast("Reintentar");
      emit(state.copyWith(status: StatusAuthentication.initial));
    }*/
  }

  Future<void> signInwithToken() async {
    //var data = {"email": "demo", "password": "demo123"};
    emit(state.copyWith(
      status: StatusWelcome.loading,
    ));

    emit(state.copyWith(
      status: StatusWelcome.loading,
    ));
  }

  Future<void> logout() async {

    await PersitentDevice().deleteToken();
    emit(state.copyWith(
      status: StatusWelcome.no_autenticado,
    ));
  }

  Future<void> createUser(
      String email, String password, String nombre, String rol) async {
    emit(state.copyWith(
      status: StatusWelcome.loading,
    ));

    /*try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final respuesta = await _usuariosRepository.crearUsuario(nombre,
          userCredential.user!.uid, userCredential.user!.email.toString(), rol);

      respuesta.fold((e) {
        ScreenMessagesService().toast(e.message.toString());
        emit(state.copyWith(status: StatusAuthentication.initial));
      }, (response) {
        ScreenMessagesService().toast("Creado Usuario ExitosaMente");
        emit(state.copyWith(status: StatusAuthentication.finish));
      });
    }  catch (e) {
      print(e);
      emit(state.copyWith(status: StatusAuthentication.initial));
    }*/
  }
}

import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:sixpackburner/device/device.dart';
import 'package:sixpackburner/domain/domain.dart';
import 'package:sixpackburner/presentations/services/screen_messages_service.dart';
import 'package:equatable/equatable.dart';



part 'welcome_state.dart';


class WelcomeCubit extends Cubit<WelcomeState> {
  WelcomeCubit() : super(WelcomeState(listBanner: []));

 

  Future<void> init() async {

   List<WelcomeBannerModel> listBanner=[];

   listBanner.add(WelcomeBannerModel(id: "",title: "",description: "¿Buscas perder grasa? ¡Vamos a lograrlo! esta app te ayudará a lograr el cuerpo que siempre has querido. Solo necesitas constancia."));
   listBanner.add(WelcomeBannerModel(id: "",title: "ASI LO LOGRAREMOS",description: "Armaremos tu plan nutricional personalizado con conteo de calorías, preteína, grasas y carbohidratos. Armaremos tu menú con tus requerimientos nutricionales"));
   listBanner.add(WelcomeBannerModel(id: "",title: "SIN DIETAS EXTREMAS",description: "Nuestro objetivo es que hagas dietas agradables, saludables y que te ayuden a conservar la masa muscular ¡Pierde solo grasa!"));

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

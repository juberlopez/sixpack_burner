import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:sixpackburner/device/device.dart';
import 'package:sixpackburner/domain/domain.dart';
import 'package:sixpackburner/domain/models/response_model.dart';
import 'package:sixpackburner/presentations/services/screen_messages_service.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:http/http.dart' as http;

import 'package:reactive_forms/reactive_forms.dart';
import 'package:sixpackburner/presentations/ui/home/view/home_view.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(this._authenticationRepository, this._generalRepository)
      : super(
            AuthenticationState(ciudades: [], ciudadesPlus: [], qr: QrModel()));

  final AuthenticationRepository _authenticationRepository;
  final GeneralRepository _generalRepository;
  late IO.Socket socket;

  Future<void> init() async {
    /*FirebaseAuth.instance
  .authStateChanges()
  .listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });*/

    getCiudades();
    //signInwithEmail("","");

    emit(state.copyWith(
      status: StatusAuthentication.hay_token,
    ));
  }

  Future<void> initSocket() async {
    /*try {
      socket = IO.io('https://sixpackburner.megaplexstars.com',
          OptionBuilder().setTransports(['websocket']).build());

      socket.onConnect((_) {
        print("connect");
        //socket.emit("chat:login", correo.toString());
      });
      socket.on('error', (data) {
        print("connect");
      });
      socket.onConnectError((data) {
        print(data);
      });
      socket.onError((data) {
        print("data");
      });
      
    } catch (e) {
      print(e);
    }*/
  }

  Future<void> signInwithEmail(String email, String clave, BuildContext context) async {
    emit(state.copyWith(status: StatusAuthentication.loading));

    final respuesta =
        await _authenticationRepository.login(correo: email, password: clave);

    respuesta.fold((e) {
      if (e.error == DomainError.QrCodeNotActivated) {
        ScreenMessagesService().toast("Aun no has escaneado el codigo qr");
        emit(state.copyWith(
            status: StatusAuthentication
                .authenticated_without_qr_code_not_activated));
      } else {
        emit(state.copyWith(status: StatusAuthentication.no_autenticado));
        ScreenMessagesService().toast(e.message.toString());
      }
    }, (response) async {
      //ScreenMessages().toast("No existe Usuario");
print("autenticado:1");

  FirebaseMessaging.instance.subscribeToTopic('burnersixpack').then((value) {
    print("Subscrito a burnersixpack");
  })
  .catchError((onError){
print(onError);
  });

await Firebase.initializeApp();
String? token= await FirebaseMessaging.instance.getToken();
            print("token generado:"+ token.toString());
 _authenticationRepository.updateToken(token.toString()).then((value) => null);
 Navigator.pushNamedAndRemoveUntil(context, HomeView.routeName, (r) => false);
      emit(state.copyWith(status: StatusAuthentication.autenticado));





    });
  }

  Future<void> registerCode(
    String code,
  ) async {
    // emit(state.copyWith(status: StatusAuthentication.autenticado));
    emit(state.copyWith(statusQr: StatusAuthentication.loading));

    print(code);

    if (code.contains("megaplexstars")) {
      try {
        var qr = code.split("qr=")[1];

        print(qr);
        var data = base64Decode(qr);

        var dataDos = ascii.decode(data);

        //ASCII.decode(data);

        print(dataDos);

        // if (dataDos.contains("BURNER")) {
          final respuesta = await _generalRepository.registroQr(dataDos);

          respuesta.fold((e) {
            //emit(state.copyWith(status: StatusAuthentication.initial));
            ScreenMessagesService().toast(e.message.toString());
            emit(state.copyWith(statusQr: StatusAuthentication.initial));
          }, (response) {
            QrModel qrModel = response.data;

            emit(state.copyWith(
                statusQr: StatusAuthentication.initial_save_code,
                //status: StatusAuthentication.autenticado,
                qr: qrModel));
          });
        // } else {
        //   ScreenMessagesService().toast("El código QR no es de Burner Stack");
        //   emit(state.copyWith(statusQr: StatusAuthentication.initial));
        // }
        //me.validate(qr);
      } catch (error) {
        ScreenMessagesService().toast(error.toString());
        //ScreenMessagesService().toast("El código QR no es de Burner Stack");
        emit(state.copyWith(statusQr: StatusAuthentication.initial));
      }
      print(code);
    } else {
      ScreenMessagesService().toast("El código QR no es de nutramerican");
      emit(state.copyWith(statusQr: StatusAuthentication.initial));
    }

    /*final respuesta =
        await _authenticationRepository.login(correo: email, password: clave);*/

    /*respuesta.fold((e) {
      if (e.error == DomainError.QrCodeNotActivated) {
        ScreenMessagesService().toast("Aun no has escaneado el codigo qr");
        emit(state.copyWith(
            status: StatusAuthentication
                .authenticated_without_qr_code_not_activated));
      } else {
        emit(state.copyWith(status: StatusAuthentication.no_autenticado));
        ScreenMessagesService().toast(e.message.toString());
      }
    }, (response) {
      //ScreenMessages().toast("No existe Usuario");
      emit(state.copyWith(status: StatusAuthentication.autenticado));
    });*/
  }

  Future<void> registerCodePlus(
    String code,
  ) async {
    // emit(state.copyWith(status: StatusAuthentication.autenticado));
    emit(state.copyWith(statusQr: StatusAuthentication.loading));

    print(code);

    if (code.length > 3) {
      try {
        final respuesta =
            await _generalRepository.registroCode(code, state.qr.id.toString());

        respuesta.fold((e) {
          //emit(state.copyWith(status: StatusAuthentication.initial));
          ScreenMessagesService().toast(e.message.toString());
          emit(state.copyWith(statusQr: StatusAuthentication.initial));
        }, (response) {
          emit(state.copyWith(
            statusQr: StatusAuthentication.autenticado,
            //status: StatusAuthentication.autenticado,
          ));
        });

        //me.validate(qr);
      } catch (error) {
        ScreenMessagesService().toast("El código QR no es de Burner Stack");
        emit(state.copyWith(statusQr: StatusAuthentication.initial));
      }
    } else {
      emit(state.copyWith(
        statusQr: StatusAuthentication.autenticado,
        //status: StatusAuthentication.autenticado,
      ));
    }

    print(code);

    /*final respuesta =
        await _authenticationRepository.login(correo: email, password: clave);*/

    /*respuesta.fold((e) {
      if (e.error == DomainError.QrCodeNotActivated) {
        ScreenMessagesService().toast("Aun no has escaneado el codigo qr");
        emit(state.copyWith(
            status: StatusAuthentication
                .authenticated_without_qr_code_not_activated));
      } else {
        emit(state.copyWith(status: StatusAuthentication.no_autenticado));
        ScreenMessagesService().toast(e.message.toString());
      }
    }, (response) {
      //ScreenMessages().toast("No existe Usuario");
      emit(state.copyWith(status: StatusAuthentication.autenticado));
    });*/
  }

  Future<void> signInwithToken() async {
    try {
      // await PersitentDevice().deleteData();
      String? user = await PersitentDevice().getUser();

      if (user!.isNotEmpty) {
        
        FirebaseMessaging.instance.getToken().then((token) {
          print("TOKEN"+token.toString());
          _authenticationRepository.updateToken(token.toString()).then((value) {
            ResponseModel data = value as ResponseModel;
            PersitentDevice().setState(data.data);
          });
        });

        try {
          String? stateQr = await PersitentDevice().getState();
          if (stateQr == "FULL") {
            //await FirebaseMessaging.instance.subscribeToTopic('fcm_test');
            FirebaseMessaging.instance.getToken().then((token) {
              _authenticationRepository
                  .updateToken(token.toString())
                  .then((value) => null);
            });

            emit(state.copyWith(
              status: StatusAuthentication.autenticado,
            ));
          } else if (stateQr == "QR") {
            emit(state.copyWith(
              status: StatusAuthentication.poll,
            ));
          } else {
            emit(state.copyWith(
              status: StatusAuthentication.scan_code,
            ));
          }
        } catch (e) {
          emit(state.copyWith(
            status: StatusAuthentication.scan_code,
          ));
        }
      }
    } catch (e) {
      emit(state.copyWith(
        status: StatusAuthentication.welcome,
      ));
    }
  }

  Future<void> logOut() async {
    print("close");
    await PersitentDevice().deleteData();
    
    emit(state.copyWith(
      status: StatusAuthentication.logout,
    ));
      }

  Future<void> createUser(
      String email, String password, String nombre, String rol) async {
    emit(state.copyWith(
      status: StatusAuthentication.loading,
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

  Future<void> registerUser(FormGroup form, String ciudad, String so) async {
    emit(state.copyWith(status: StatusAuthentication.loading));
  print("El sistema operativo es: ${so}");
    var dataForm = form.value.values.toList();
    var nombre = dataForm[0];
    var contrasena = dataForm[1];
    var numeroCelular = dataForm[3];
    var correo = dataForm[4];

    final respuesta = await _authenticationRepository.register(
        correo: correo.toString(),
        password: contrasena.toString(),
        ciudad: ciudad,
        so: so,
        numeroCelular: numeroCelular.toString(),
        nombre: nombre.toString());

    respuesta.fold((e) {
      emit(state.copyWith(status: StatusAuthentication.no_autenticado));
      ScreenMessagesService().toast(e.message.toString());
    }, (response) {
      ResponseModel responseModel = response;
      UserPlusModel user = responseModel.data;
      /*socket = IO.io('https://sixpackburner.megaplexstars.com',
          OptionBuilder().setTransports(['websocket']).build());*/

      PersitentDevice().setState("AUTH");
      /* ScreenMessagesService().toast(
            "Tu cuenta ha sido validada, por favor escanea el código que aparece al interior del tarro");*/
      //socket.dispose();

      PersitentDevice().setUser(UserPlusModel(
              ciudad: user.ciudad,
              correo: user.correo,
              foto: user.foto,
              id: user.id,
              numeroCelular: user.numeroCelular,
              usuario: user.usuario)
          .toRawJson());

      emit(state.copyWith(
          status: StatusAuthentication
              .authenticated_without_qr_code_not_activated));

      /*socket.onConnect((_) {
        print("connect");
        socket.emit("chat:login", correo.toString());
        //socket.emit("chat:login", correo.toString());
      });
      socket.on('error', (data) {
        print(data);
      });
      socket.onConnectError((data) {
        print(data);
      });
      socket.onError((data) {
        print(data);
      });

      socket.on("validate", (msg) {
        PersitentDevice().setState("AUTH");
        ScreenMessagesService().toast(
            "Tu cuenta ha sido validada, por favor escanea el código que aparece al interior del tarro");
        socket.dispose();

        PersitentDevice().setUser(UserPlusModel(
                ciudad: user.ciudad,
                correo: user.correo,
                foto: user.foto,
                id: user.id,
                numeroCelular: user.numeroCelular,
                usuario: user.usuario)
            .toRawJson());
               
        emit(state.copyWith(
            status: StatusAuthentication
                .authenticated_without_qr_code_not_activated));
      });

      emit(state.copyWith(
          statusSocket: StatusAuthentication.validate_mail,
          status: StatusAuthentication.initial)
          );*/
    });
  }

  Future<void> restorePassword(String correo) async {
    emit(state.copyWith(status: StatusAuthentication.loading));

    final respuesta = await _authenticationRepository.restorePassword(
      correo: correo.toString(),
    );

    respuesta.fold((e) {
      emit(state.copyWith(status: StatusAuthentication.no_autenticado));
      ScreenMessagesService().toast(e.message.toString());
    }, (response) {
      //ScreenMessages().toast("No existe Usuario");
      emit(state.copyWith(status: StatusAuthentication.no_autenticado));
    });
  }

  Future<void> getCiudades() async {
    // http.get(Uri.parse('https://nutramerican.com/api_MegaplexStar/api/ciudades/'))
    //     .then((response) {
    //   Iterable list = json.decode(response.body);
    //   List<CityModel> listaCiudades =
    //       list.map((model) => CityModel.fromJson(model)).toList();

    //   emit(state.copyWith(
    //       ciudades: listaCiudades,
    //       ciudadesPlus: listaCiudades.map((e) => e.ciudada).toList()));
    //   print(listaCiudades);
    // });

  rootBundle.loadString('assets/data/ciudades.json')
        .then((response) {
       Iterable list = json.decode(response);
      List<CityModel> listaCiudades =
          list.map((model) => CityModel.fromJson(model)).toList();

      emit(state.copyWith(
          ciudades: listaCiudades,
          ciudadesPlus: listaCiudades.map((e) => e.ciudada).toList()));

      print(listaCiudades);
    });





  }
}

import 'package:sixpackburner/data/data.dart';
import 'package:sixpackburner/data/entities/response/register_entity_response.dart';
import 'package:sixpackburner/device/device.dart';
import 'package:sixpackburner/domain/exceptions/domain_exception.dart';
import 'package:sixpackburner/domain/models/response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../domain.dart';

class AuthenticationRepository {
  AutenticationRemote _autenticationDataSource = AutenticationRemote();

  Future<Either<DomainException, ResponseModel>> login(
      {required String correo, required String password}) async {
    final response = await _autenticationDataSource
        .login(LoginEntityRequest(correo: correo, pass: password));

    return response.fold(
        (dataExceptiond) => Left(DomainException(
            error: DomainError.Unknown,
            message: dataExceptiond.message)), (responseData) async {
      LoginEntityResponse data = responseData.data;
      try {
        PersitentDevice().setUser(UserPlusModel(
                ciudad: data.user!.ciudad,
                correo: data.user!.correo,
                foto: data.user!.foto,
                id: data.user!.id,
                numeroCelular: data.user!.numeroCelular,
                usuario: data.user!.usuario)
            .toRawJson());
        PersitentDevice().setState(data.state.toString());
        //PersitentDevice().setReporte(data.user!.jsonDatos!.toRawJson());
        //PersitentDevice().setDietas(data.user!.jsonDietas!.toRawJson());
      } catch (e) {}

      if (data.state == "FULL") {
        PersitentDevice().setReporte(data.user!.jsonDatos!.toRawJson());
        PersitentDevice().setDietas(data.user!.jsonDietas!.toRawJson());
        return Right(ResponseModel(
            data: UserModel(
                id: data.user!.id,
                usuario: data.user!.usuario,
                correo: data.user!.correo,
                numeroCelular: data.user!.numeroCelular,
                ciudad: data.user!.ciudad,
                foto: data.user!.foto)));
      } else {
         PersitentDevice().setReporte(data.user!.jsonDatos!.toRawJson());
         PersitentDevice().setDietas(data.user!.jsonDietas!.toRawJson());
        return Left(DomainException(
            error: DomainError.QrCodeNotActivated,
            message: "",
            data: UserModel(
                id: data.user!.id,
                usuario: data.user!.usuario,
                correo: data.user!.correo,
                numeroCelular: data.user!.numeroCelular,
                ciudad: data.user!.ciudad,
                foto: data.user!.foto)));
      }
    });
  }

  Future<Either<DomainException, ResponseModel>> restorePassword({
    required String correo,
  }) async {
    final response = await _autenticationDataSource
        .passwordRecovery(PasswordRecoveryEntityRequest(email: correo));

    return response.fold(
        (dataExceptiond) => Left(DomainException(
            error: DomainError.Unknown,
            message: dataExceptiond.message)), (responseData) {
      PasswordRecoveryEntityResponse response = responseData.data;

      return Right(ResponseModel(
        message: response.message,
      ));
    });
  }

  Future<Either<DomainException, ResponseModel>> register(
      {required String correo,
      required String password,
      required String ciudad,
      required String so,
      required String numeroCelular,
      required String nombre}) async {

    //String? token = await FirebaseMessaging.instance.getAPNSToken();


    final response = await _autenticationDataSource.register(
        RegisterEntityRequest(
            ciudad: ciudad,
            usuario: nombre,
            correo: correo,
            so:so,
            numeroCelular: int.parse(numeroCelular),
            pass: password,
            idToken: ""));

    return response.fold(
        (dataExceptiond) => Left(DomainException(
            error: DomainError.Unknown,
            message: dataExceptiond.message)), (responseData) {
      RegisterEntityResponse data = responseData.data;

      if (data.mesage == "Usuario Registrado") {
        return Right(ResponseModel(
            data: UserPlusModel(
                id: data.user!.id,
                usuario: data.user!.usuario,
                correo: data.user!.correo,
                numeroCelular: data.user!.numeroCelular,
                ciudad: data.user!.ciudad,
                foto: "")));
      } else {
        return Left(DomainException(
            error: DomainError.UserNotFound,
            message: data.mesage,
            data: UserPlusModel(
                id: data.user!.id,
                usuario: data.user!.usuario,
                correo: data.user!.correo,
                numeroCelular: data.user!.numeroCelular,
                ciudad: data.user!.ciudad,
                foto: "data.user!.foto")));
      }
    });
  }

  Future<Either<DomainException, ResponseModel>> updateToken(
      String token) async {

    
    String? dataUser = await PersitentDevice().getUser();

    UserPlusModel user = UserPlusModel.fromRawJson(dataUser!);

    final response = await _autenticationDataSource.updateToken({"id": user.id, "token": token});
        

    return response.fold(
        (dataExceptiond) => Left(DomainException(
            error: DomainError.Unknown,
            message: dataExceptiond.message)), (responseData) async {
      PersitentDevice().setUser(user.toRawJson());
      return Right(ResponseModel(data: responseData.data));
    });
  }
}

import 'package:burnet_stack/data/data.dart';
import 'package:burnet_stack/device/device.dart';
import 'package:burnet_stack/domain/exceptions/domain_exception.dart';
import 'package:burnet_stack/domain/models/response_model.dart';
import 'package:dartz/dartz.dart';

import '../domain.dart';

class GeneralRepository {
  GeneralRemote _remoteDataSource = GeneralRemote();

  Future<Either<DomainException, ResponseModel>> getChallenge() async {
    final response = await _remoteDataSource.getChallenge();

    return response.fold(
        (dataExceptiond) => Left(DomainException(
            error: DomainError.Unknown,
            message: dataExceptiond.message)), (responseData) async {
      ChallengeEntityResponse data = responseData.data;

      return Right(ResponseModel(
          data: data.challenge!
              .map((e) => ChallengeModel(
                  id: e.id,
                  title: e.title,
                  image: e.image,
                  body: e.body,
                  fecha: e.fecha,
                  data: e.data))
              .toList()));
    });
  }

  Future<Either<DomainException, ResponseModel>> getProgresos() async {
    String? dataUser = await PersitentDevice().getUser();

    UserPlusModel user = UserPlusModel.fromRawJson(dataUser!);

    final response = await _remoteDataSource.getProgresos(user.id!);

    return response.fold(
        (dataExceptiond) => Left(DomainException(
            error: DomainError.Unknown,
            message: dataExceptiond.message)), (responseData) async {
      MyProgressEntityResponse data = responseData.data;

      return Right(ResponseModel(
          data: data.myProgress!
              .map((e) => MyProgressModel(
                  id: e.id,
                  peso: e.peso,
                  fecha: e.fecha,
                  fotos: Photo(
                      large: e.fotos!.large,
                      medium: e.fotos!.medium,
                      small: e.fotos!.small)))
              .toList()));
    });
  }

  Future<Either<DomainException, ResponseModel>> addControl(
      String foto, String peso) async {
    String? dataUser = await PersitentDevice().getUser();

    UserPlusModel user = UserPlusModel.fromRawJson(dataUser!);

    final response = await _remoteDataSource
        .addControl({"foto": foto, "id": user.id, "peso": peso});

    return response.fold(
        (dataExceptiond) => Left(DomainException(
            error: DomainError.Unknown,
            message: dataExceptiond.message)), (responseData) async {
      MyProgressEntityResponse data = responseData.data;

      return Right(ResponseModel(
          data: data.myProgress!
              .map((e) => MyProgressModel(
                  id: e.id,
                  peso: e.peso,
                  fecha: e.fecha,
                  fotos: Photo(
                      large: e.fotos!.large,
                      medium: e.fotos!.medium,
                      small: e.fotos!.small)))
              .toList()));
    });
  }

  Future<Either<DomainException, ResponseModel>> deleteProgresos(int id) async {
    final response = await _remoteDataSource.deleteProgresos(id);

    return response.fold(
        (dataExceptiond) => Left(DomainException(
            error: DomainError.Unknown,
            message: dataExceptiond.message)), (responseData) async {
      MyProgressEntityResponse data = responseData.data;

      return Right(ResponseModel(
          data: data.myProgress!
              .map((e) => MyProgressModel(
                  id: e.id,
                  peso: e.peso,
                  fecha: e.fecha,
                  fotos: Photo(
                      large: e.fotos!.large,
                      medium: e.fotos!.medium,
                      small: e.fotos!.small)))
              .toList()));
    });
  }

  Future<Either<DomainException, ResponseModel>> addDieta(
      ReportModel reportModel) async {
    final response = await _remoteDataSource.addDieta(reportModel.toJson());

    return response.fold(
        (dataExceptiond) => Left(DomainException(
            error: DomainError.Unknown,
            message: dataExceptiond.message)), (responseData) async {
      PollEntityResponse data = responseData.data;

      PersitentDevice().setDietas(
          JsonDietas(dietas: data.dietas, info: data.info).toRawJson());
      PersitentDevice().setReporte(reportModel.toRawJson());

      return Right(ResponseModel(data: data.info));
    });
  }

  Future<Either<DomainException, ResponseModel>> registroQr(
      String codigo) async {
    String? dataUser = await PersitentDevice().getUser();

    UserPlusModel user = UserPlusModel.fromRawJson(dataUser!);

    final response = await _remoteDataSource.registroQr({
      "id_user": user.id,
      "id_recibo": codigo,
    });

    return response.fold(
        (dataExceptiond) => Left(DomainException(
            error: DomainError.Unknown,
            message: dataExceptiond.message)), (responseData) async {
      QrEntityResponse data = responseData.data;

      PersitentDevice().setState("QR");

      return Right(ResponseModel(
          data: QrModel(code: data.code, message: data.message, id: data.id)));
    });
  }

  Future<Either<DomainException, ResponseModel>> registroCode(
      String codigo, String id) async {
    String? dataUser = await PersitentDevice().getUser();

    UserPlusModel user = UserPlusModel.fromRawJson(dataUser!);

    final response =
        await _remoteDataSource.registroCode({"id": id, "codigo": codigo});

    return response.fold(
        (dataExceptiond) => Left(DomainException(
            error: DomainError.Unknown,
            message: dataExceptiond.message)), (responseData) async {
      QrEntityResponse data = responseData.data;

      return Right(ResponseModel(
          data: QrModel(code: data.code, message: data.message, id: data.id)));
    });
  }

  Future<Either<DomainException, ResponseModel>> updatePhotoBase64(
      String imagen) async {
    String? dataUser = await PersitentDevice().getUser();

    UserPlusModel user = UserPlusModel.fromRawJson(dataUser!);

    final response = await _remoteDataSource
        .updatePhotoBase64({"id": user.id, "foto": imagen});

    return response.fold(
        (dataExceptiond) => Left(DomainException(
            error: DomainError.Unknown,
            message: dataExceptiond.message)), (responseData) async {
      //QrEntityResponse data = responseData.data;
      user.foto = responseData.data +"?date="+ DateTime.now().toIso8601String();
      PersitentDevice().setUser(user.toRawJson());
      return Right(ResponseModel(data: user.foto));
    });
  }
}

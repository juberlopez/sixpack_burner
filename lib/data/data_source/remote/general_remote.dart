import 'package:burnet_stack/data/api/api.dart';
import 'package:dartz/dartz.dart';
import 'package:burnet_stack/data/exceptions/data_exception.dart';
import 'package:burnet_stack/data/entities/response/entity_response.dart';
import '../../data.dart';
import '../general_data_source.dart';

class GeneralRemote implements GeneralDataSource {
  Client _client = Client();

  @override
  Future<Either<DataException, EntityResponse>> getChallenge() async {
    var dataResponse;

    try {
      dataResponse = await _client.httpGet('retos');

      return Right(EntityResponse(
        data: ChallengeEntityResponse.fromJson(dataResponse),
      ));
    } catch (e) {
      return Left(DataException(message: e.toString()));
    }
  }

  @override
  Future<Either<DataException, EntityResponse>> getProgresos(
      int dataReques) async {
    var dataResponse;

    try {
      dataResponse = await _client
          .httpGetQueryParameters("controles/", {"id": dataReques});

      return Right(EntityResponse(
        data: MyProgressEntityResponse.fromJson(dataResponse),
      ));
    } catch (e) {
      return Left(DataException(message: e.toString()));
    }
  }

  @override
  Future<Either<DataException, EntityResponse>> addControl(
      Map<String, dynamic> dataReques) async {
    var dataResponse;

    try {
      dataResponse = await _client.post("control/", dataReques);

      return Right(EntityResponse(
        data: MyProgressEntityResponse.fromJson(dataResponse["controles"]),
      ));
    } catch (e) {
      return Left(DataException(message: e.toString()));
    }
  }

  @override
  Future<Either<DataException, EntityResponse>> deleteProgresos(
      int dataReques) async {
    var dataResponse;

    try {
      dataResponse =
          await _client.deletePlus("controles/", dataReques.toString());

      return Right(EntityResponse(
        data: MyProgressEntityResponse.fromJson(dataResponse),
      ));
    } catch (e) {
      return Left(DataException(message: e.toString()));
    }
  }

  @override
  Future<Either<DataException, EntityResponse>> addDieta(
      Map<String, dynamic> dataReques) async {
    var dataResponse;

    try {
      dataResponse = await _client.post("dieta/", dataReques);
      return Right(EntityResponse(
        data: PollEntityResponse.fromJson(dataResponse),
      ));
    } catch (e) {
      return Left(DataException(message: e.toString()));
    }
  }

   @override
  Future<Either<DataException, EntityResponse>> registroQr(
      Map<String, dynamic> dataReques) async {
    var dataResponse;

    try {
      dataResponse = await _client.post("registreqr/", dataReques);
      return Right(EntityResponse(
        data: QrEntityResponse.fromJson(dataResponse),
      ));
    } catch (e) {
      return Left(DataException(message: e.toString()));
    }
  }

     @override
  Future<Either<DataException, EntityResponse>> registroCode(
      Map<String, dynamic> dataReques) async {
    var dataResponse;

    try {
      dataResponse = await _client.put("registrecode/", dataReques);
      return Right(EntityResponse(
        data: QrEntityResponse.fromJson(dataResponse),
      ));
    } catch (e) {
      return Left(DataException(message: e.toString()));
    }
  }

     @override
  Future<Either<DataException, EntityResponse>> updatePhotoBase64(
      Map<String, dynamic> dataReques) async {
    var dataResponse;

    try {
      dataResponse = await _client.put("updatephoto/", dataReques);
      return Right(EntityResponse(
        data: dataResponse["foto"],
      ));
    } catch (e) {
      return Left(DataException(message: e.toString()));
    }
  }
}



import 'package:sixpackburner/data/api/api.dart';
import 'package:sixpackburner/data/entities/entities.dart';
import 'package:sixpackburner/data/entities/response/register_entity_response.dart';
import 'package:sixpackburner/data/exceptions/data_exception.dart';
import 'package:dartz/dartz.dart';
import '../autentication_data_source.dart';

class AutenticationRemote implements AutenticationDataSource {
  Client _client = Client();

  @override
  Future<Either<DataException, EntityResponse>> login(
      LoginEntityRequest dataReques) async {
    var dataResponse;

    try {
      dataResponse =
          await _client.httpGetQueryParameters("login/", dataReques.toMap());

      return Right(EntityResponse(
        data: LoginEntityResponse.fromJson(dataResponse),
      ));

    } catch (e) {
      return Left(DataException(message: e.toString()));
    }
  }

  @override
  Future<Either<DataException, EntityResponse>> passwordRecovery(
      PasswordRecoveryEntityRequest dataReques) async {
        var dataResponse;
    try {
      dataResponse =
          await _client.httpGetQueryParameters("emailrestartpass/", dataReques.toMap());

      return Right(EntityResponse(
        data: PasswordRecoveryEntityResponse.fromMap(dataResponse),
      ));

    } catch (e) {
      return Left(DataException(message: e.toString()));
    }
  }

  @override
  Future<Either<DataException, EntityResponse>> register(
      RegisterEntityRequest dataReques) async {
         var dataResponse;

    try {
      dataResponse =
          await _client.post("/v2/newUser/", dataReques.toMap());

      return Right(EntityResponse(
        data: RegisterEntityResponse.fromMap(dataResponse),
      ));

    } catch (e) {
      return Left(DataException(message: e.toString()));
    }
  }
      @override
  Future<Either<DataException, EntityResponse>> updateToken(
      Map<String, dynamic> dataReques) async {
        
    print("token enviado"+ dataReques.toString());

    var dataResponse;
    try {
      dataResponse = await _client.put("updatetoken/", dataReques);
      return Right(EntityResponse(
        data: dataResponse["state"],
      ));
    } catch (e) {
      return Left(DataException(message: e.toString()));
    }
 
  }
}

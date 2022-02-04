import 'package:sixpackburner/data/api/api.dart';
import 'package:dartz/dartz.dart';
import 'package:sixpackburner/data/exceptions/data_exception.dart';
import 'package:sixpackburner/data/entities/response/entity_response.dart';
import 'package:sixpackburner/data/entities/request/login_entity_request.dart';

import '../../data.dart';
import '../recipe_data_source.dart';

class RecipeRemote implements RecipeDataSource {
  Client _client = Client();

  @override
  Future<Either<DataException, EntityResponse>> getRecipes(
      int dataReques) async {
    var dataResponse;

    try {
      dataResponse =
          await _client.httpGetQueryParameters("recetas/", {"id": dataReques});

      return Right(EntityResponse(
        data: RecipeEntityResponse.fromJson(dataResponse),
      ));
    } catch (e) {
      return Left(DataException(message: e.toString()));
    }
  }

  @override
  Future<Either<DataException, EntityResponse>> likeRecipes(
      Map<String, dynamic> dataReques) async {
    var dataResponse;

    try {
      dataResponse = await _client.put("like/", dataReques);

      return Right(EntityResponse(
          codeMessage:
              ResponseCodeMessageEntity(codigomensaje: dataResponse["msg"])));
    } catch (e) {
      return Left(DataException(message: e.toString()));
    }
  }

  @override
  Future<Either<DataException, EntityResponse>> unLikeRecipes(
      Map<String, dynamic> dataReques) async {
    var dataResponse;
    try {
      dataResponse = await _client.put("unlike/", dataReques);

      return Right(EntityResponse(
        codeMessage:
            ResponseCodeMessageEntity(codigomensaje: dataResponse["msg"]),
      ));
    } catch (e) {
      return Left(DataException(message: e.toString()));
    }
  }

  @override
  Future<Either<DataException, EntityResponse>> favoriteRecipes(Map<String, dynamic> dataReques) async {
   var dataResponse;
    try {
      dataResponse = await _client.put("favorite/", dataReques);

      return Right(EntityResponse(
        codeMessage:
            ResponseCodeMessageEntity(codigomensaje: dataResponse["msg"]),
      ));
    } catch (e) {
      return Left(DataException(message: e.toString()));
    }
  }

  @override
  Future<Either<DataException, EntityResponse>> unFavoriteRecipes(Map<String, dynamic> dataReques) async {
    var dataResponse;
    try {
      dataResponse = await _client.put("unfavorite/", dataReques);

      return Right(EntityResponse(
        codeMessage:
            ResponseCodeMessageEntity(codigomensaje: dataResponse["msg"]),
      ));
    } catch (e) {
      return Left(DataException(message: e.toString()));
    }
  }
}

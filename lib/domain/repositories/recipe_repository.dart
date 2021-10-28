import 'package:burnet_stack/data/data.dart';
import 'package:burnet_stack/device/device.dart';
import 'package:burnet_stack/domain/exceptions/domain_exception.dart';
import 'package:burnet_stack/domain/models/response_model.dart';
import 'package:dartz/dartz.dart';

import '../domain.dart';

class RecipeRepository {
  RecipeRemote _remoteDataSource = RecipeRemote();

  Future<Either<DomainException, ResponseModel>> getRecipes() async {
    String? dataUser = await PersitentDevice().getUser();

    UserPlusModel user = UserPlusModel.fromRawJson(dataUser!);

    final response = await _remoteDataSource.getRecipes(user.id!);

    return response.fold(
        (dataExceptiond) => Left(DomainException(
            error: DomainError.Unknown,
            message: dataExceptiond.message)), (responseData) async {
      RecipeEntityResponse data = responseData.data;

      return Right(ResponseModel(
          data: data.recipe!
              .map((e) => RecipeModel(
                  id: e.id,
                  name: e.name,
                  cover: e.cover,
                  category: e.category,
                  description: e.description,
                  sharelink: e.sharelink,
                  likes: e.likes,
                  favorites: e.favorites,
                  isLike: e.isLike,
                  isFavorite: e.isFavorite))
              .toList()));
    });
  }

  Future<Either<DomainException, ResponseModel>> statelikeRecipes(
      String idReceta, bool stateLike) async {
    String? dataUser = await PersitentDevice().getUser();

    UserPlusModel user = UserPlusModel.fromRawJson(dataUser!);
    

    if (!stateLike) {
      
     final response = await _remoteDataSource
          .unLikeRecipes({"id_receta": idReceta, "id_user": user.id});
      return response.fold(
          (dataExceptiond) => Left(DomainException(
              error: DomainError.Unknown,
              message: dataExceptiond.message)),(responseData)async{

        return Right(ResponseModel(message: responseData.codeMessage!.codigomensaje));
      });
    }
     else {
      final response = await _remoteDataSource
          .likeRecipes({"id_receta": idReceta, "id_user": user.id});
      return response.fold(
          (dataExceptiond) => Left(DomainException(
              error: DomainError.Unknown,
              message: dataExceptiond.message)), (responseData) async {
        return Right(ResponseModel(message: responseData.codeMessage!.codigomensaje));
      });
    }
  }

  Future<Either<DomainException, ResponseModel>> stateFavoriteRecipes(
      String idReceta, bool stateFavorite) async {
    String? dataUser = await PersitentDevice().getUser();

    UserPlusModel user = UserPlusModel.fromRawJson(dataUser!);
    

    if (!stateFavorite) {
      
     final response = await _remoteDataSource
          .unFavoriteRecipes({"id_receta": idReceta, "id_user": user.id});
      return response.fold(
          (dataExceptiond) => Left(DomainException(
              error: DomainError.Unknown,
              message: dataExceptiond.message)),(responseData)async{

        return Right(ResponseModel(message: responseData.codeMessage!.codigomensaje));
      });
    }
     else {
      final response = await _remoteDataSource
          .favoriteRecipes({"id_receta": idReceta, "id_user": user.id});
      return response.fold(
          (dataExceptiond) => Left(DomainException(
              error: DomainError.Unknown,
              message: dataExceptiond.message)), (responseData) async {
        return Right(ResponseModel(message: responseData.codeMessage!.codigomensaje));
      });
    }
  }
}

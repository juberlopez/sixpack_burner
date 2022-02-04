import 'package:sixpackburner/data/entities/entities.dart';
import 'package:sixpackburner/data/exceptions/data_exception.dart';
import 'package:dartz/dartz.dart';


abstract class RecipeDataSource {
Future<Either<DataException, EntityResponse>> getRecipes( int dataReques);
Future<Either<DataException, EntityResponse>> likeRecipes( Map<String, dynamic> dataReques);
Future<Either<DataException, EntityResponse>> unLikeRecipes( Map<String, dynamic> dataReques);
Future<Either<DataException, EntityResponse>> favoriteRecipes( Map<String, dynamic> dataReques);
Future<Either<DataException, EntityResponse>> unFavoriteRecipes( Map<String, dynamic> dataReques);
//Future<Either<DataException, EntityResponse>> register( RegisterEntityRequest dataReques);
//Future<Either<DataException, EntityResponse>> passwordRecovery( PasswordRecoveryEntityRequest dataReques);

}
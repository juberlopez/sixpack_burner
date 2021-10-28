import 'package:burnet_stack/data/entities/entities.dart';
import 'package:burnet_stack/data/exceptions/data_exception.dart';
import 'package:dartz/dartz.dart';


abstract class AutenticationDataSource {
Future<Either<DataException, EntityResponse>> login( LoginEntityRequest dataReques);
Future<Either<DataException, EntityResponse>> register( RegisterEntityRequest dataReques);
Future<Either<DataException, EntityResponse>> passwordRecovery( PasswordRecoveryEntityRequest dataReques);
Future<Either<DataException, EntityResponse>> updateToken(Map<String, dynamic> dataReques);

}
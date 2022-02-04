import 'package:sixpackburner/data/entities/entities.dart';
import 'package:sixpackburner/data/exceptions/data_exception.dart';
import 'package:dartz/dartz.dart';


abstract class GeneralDataSource {
Future<Either<DataException, EntityResponse>> getChallenge();
Future<Either<DataException, EntityResponse>> getProgresos(int dataReques);
Future<Either<DataException, EntityResponse>> addControl(Map<String, dynamic> dataReques);
Future<Either<DataException, EntityResponse>> deleteProgresos(int dataReques);
Future<Either<DataException, EntityResponse>> addDieta(Map<String, dynamic> dataReques);
Future<Either<DataException, EntityResponse>> registroQr(Map<String, dynamic> dataReques);
Future<Either<DataException, EntityResponse>> registroCode(Map<String, dynamic> dataReques);
Future<Either<DataException, EntityResponse>> updatePhotoBase64(Map<String, dynamic> dataReques);

//Future<Either<DataException, EntityResponse>> register( RegisterEntityRequest dataReques);
//Future<Either<DataException, EntityResponse>> passwordRecovery( PasswordRecoveryEntityRequest dataReques);

}
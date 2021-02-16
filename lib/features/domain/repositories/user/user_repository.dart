import 'package:dartz/dartz.dart';
import '../../entities/entities.dart';
import '../../../../core/error/failure.dart';

abstract class UserRepository {
  Future<Either<Failure, UserResponseEntity>> getUser();
}

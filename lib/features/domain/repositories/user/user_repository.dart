import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_architecture/features/domain/entities/entities.dart';
import '../../../../core/error/failure.dart';

abstract class UserRepository {
  Future<Either<Failure, UserResponseEntity>> getUser();
}

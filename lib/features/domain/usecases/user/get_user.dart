import 'package:flutter_tdd_architecture/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_architecture/core/usecase/usecase.dart';
import 'package:flutter_tdd_architecture/features/domain/repositories/user/user_repository.dart';
import '../../entities/entities.dart';

class GetUser extends UseCase<UserEntity, NoParams> {
  final UserRepository userRepository;

  GetUser(this.userRepository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams param) async {
    return await userRepository.getUser();
  }
}

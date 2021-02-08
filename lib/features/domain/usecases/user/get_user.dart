import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/usecase/usecase.dart';
import '../../repositories/user/user_repository.dart';
import '../../entities/entities.dart';

class GetUser extends UseCase<UserEntity, NoParams> {
  final UserRepository userRepository;

  GetUser(this.userRepository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams param) async {
    return await userRepository.getUser();
  }
}

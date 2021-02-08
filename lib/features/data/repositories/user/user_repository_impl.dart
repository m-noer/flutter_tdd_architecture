import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../../domain/repositories/user/user_repository.dart';
import '../../datasources/local_data_source/user_local_data_source.dart';
import '../../datasources/remote_data_source/user_remote_data_source.dart';
import '../../models/user/users_response.dart';

typedef Future<UsersResponse> _UserChooser();

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, UsersResponse>> getUser() async {
    return await _getUser(() {
      return remoteDataSource.getUser();
    });
  }

  Future<Either<Failure, UsersResponse>> _getUser(
    _UserChooser getUser2,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUser = await getUser2();
        localDataSource.cacheUser(remoteUser);
        return Right(remoteUser);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localUser = await localDataSource.getUser();
        return Right(localUser);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_architecture/core/error/exception.dart';
import 'package:flutter_tdd_architecture/core/error/failure.dart';
import 'package:flutter_tdd_architecture/core/network/network_info.dart';
import 'package:flutter_tdd_architecture/features/data/datasources/local_data_source/user_local_data_source.dart';
import 'package:flutter_tdd_architecture/features/data/datasources/remote_data_source/user_remote_data_source.dart';
import 'package:flutter_tdd_architecture/features/data/models/models.dart';
import 'package:flutter_tdd_architecture/features/data/repositories/user/user_repository_impl.dart';
import 'package:flutter_tdd_architecture/features/domain/repositories/user/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock implements UserRemoteDataSource {}

class MockLocalDataSource extends Mock implements UserLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  UserRepository repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = UserRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is Offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getUser', () {
    // DATA FOR THE MOCKS AND ASSERTIONS
    // We'll use these three variables throughout all
    final userModel = UserModel(
        id: 1,
        email: 'mnoer@outlook.com',
        firstName: 'Muhammad',
        lastName: 'Noer',
        avatar: 'https://reqres.in/img/faces/7-image.jpg');

    final userResponse = UsersResponse(
      page: 2,
      perPage: 6,
      total: 12,
      totalPages: 2,
      data: [userModel],
    );

    test('should check if the device if online', () {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.getUser();
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test('should return remote data when the call to remote data source',
          () async {
        // arrange
        when(mockRemoteDataSource.getUser())
            .thenAnswer((_) async => userResponse);
        // act
        final result = await repository.getUser();
        // assert
        verify(mockRemoteDataSource.getUser());
        expect(result, equals(Right(userResponse)));
      });

      test(
          'should cache the data locally when the call to remote data source is successfull',
          () async {
        // arrange
        when(mockRemoteDataSource.getUser())
            .thenAnswer((_) async => userResponse);
        // act
        await repository.getUser();
        // assert
        verify(mockRemoteDataSource.getUser());
        verify(mockLocalDataSource.cacheUser(userResponse));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrage
        when(mockRemoteDataSource.getUser()).thenThrow(ServerException());
        // act
        final result = await repository.getUser();
        // assert
        verify(mockRemoteDataSource.getUser());
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestsOffline(() {
      test(
          'should return last locally cached data when the cached data is present',
          () async {
        // arrange
        when(mockLocalDataSource.getUser())
            .thenAnswer((_) async => userResponse);
        // act
        final result = await repository.getUser();
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getUser());
        expect(result, equals(Right(userResponse)));
      });

      test('should return CacheFailure when there is no cached data present',
          () async {
        // arrage
        when(mockLocalDataSource.getUser()).thenThrow(CacheException());
        // act
        final result = await repository.getUser();
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getUser());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}

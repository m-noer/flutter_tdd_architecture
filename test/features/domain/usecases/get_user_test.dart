import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_architecture/core/usecase/usecase.dart';
import 'package:flutter_tdd_architecture/features/domain/entities/user/user_entity.dart';
import 'package:flutter_tdd_architecture/features/domain/entities/user/user_response_entity.dart';
import 'package:flutter_tdd_architecture/features/domain/repositories/user/user_repository.dart';
import 'package:flutter_tdd_architecture/features/domain/usecases/user/get_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  GetUser usecase;
  MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = GetUser(mockUserRepository);
  });

  final userEntity = UserEntity(
    id: 1,
    email: 'mnoer@outlook.com',
    firstName: 'Muhammad',
    lastName: 'Noer',
    avatar: 'https://reqres.in/img/faces/7-image.jpg',
  );

  final userResponseEntity = UserResponseEntity(
    page: 2,
    perPage: 6,
    total: 12,
    totalPages: 2,
    data: [userEntity],
  );

  test('Should get user from repository', () async {
    // arrange
    when(mockUserRepository.getUser())
        .thenAnswer((_) async => Right(userResponseEntity));

    // act
    final result = await usecase(NoParams());

    // assert
    // usecase should simply return whatever was returned from repository
    expect(result, Right(userEntity));
    // verify that method has been called on the repository
    verify(mockUserRepository.getUser());
    // Only the above method should be called and nothing more.
    verifyNoMoreInteractions(mockUserRepository);
  });
}

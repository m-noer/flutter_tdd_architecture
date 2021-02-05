import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_architecture/core/usecase/usecase.dart';
import 'package:flutter_tdd_architecture/features/domain/entities/user/user_entity.dart';
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
    avatar: 'aca',
    first_name: 'Muhammad',
    last_name: 'Noer',
  );

  test('Should get user from repository', () async {
    // arrange
    when(mockUserRepository.getUser())
        .thenAnswer((_) async => Right(userEntity));

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

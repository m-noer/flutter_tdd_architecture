import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_architecture/core/error/failure.dart';
import 'package:flutter_tdd_architecture/core/usecase/usecase.dart';
import 'package:flutter_tdd_architecture/features/data/models/models.dart';
import 'package:flutter_tdd_architecture/features/domain/usecases/usecases.dart';
import 'package:flutter_tdd_architecture/features/presentation/bloc/user/user_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetUser extends Mock implements GetUser {}

void main() {
  UserBloc bloc;
  MockGetUser mockGetUser;

  setUp(() {
    mockGetUser = MockGetUser();

    bloc = UserBloc(user: mockGetUser);
  });

  test('initialState should be empty', () {
    // assert
    expect(bloc.initialState, equals(UserInitial()));
  });

  group('GetUser', () {
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

    test('should get data from user use case', () async {
      // arrange
      when(mockGetUser(any)).thenAnswer((_) async => Right(userResponse));

      // act
      bloc.add(GetUserEvent());
      await untilCalled(mockGetUser(any));

      // assert
      verify(mockGetUser(NoParams()));
    });

    test(
        'should emit [UserLoading, UserLoaded] when data is gottern successfully',
        () async {
      // arrage
      when(mockGetUser(any)).thenAnswer((_) async => Right(userResponse));

      // assert later
      final expected = [
        UserLoading(),
        UserLoaded(userResponseEntity: userResponse),
      ];
      expectLater(bloc, emitsInOrder(expected));

      // act
      bloc.add(GetUserEvent());
    });

    test('should emit [UserLoading, UserError] when getting data fails',
        () async {
      // arrage
      when(mockGetUser(any)).thenAnswer((_) async => Left(ServerFailure()));

      // assert later
      final expected = [
        UserLoading(),
        UserError(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc, emitsInOrder(expected));

      // act
      bloc.add(GetUserEvent());
    });

    test(
        'should emit [UserLoading, UserError] with a proper message for the error when getting data fails',
        () async {
      // arrage
      when(mockGetUser(any)).thenAnswer((_) async => Left(CacheFailure()));

      // assert later
      final expected = [
        UserLoading(),
        UserError(message: CACHE_FAILURE_MESSAGE),
      ];
      expectLater(bloc, emitsInOrder(expected));

      // act
      bloc.add(GetUserEvent());
    });
  });
}

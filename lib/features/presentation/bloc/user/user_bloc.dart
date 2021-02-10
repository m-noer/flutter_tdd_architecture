import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_tdd_architecture/core/error/failure.dart';
import 'package:flutter_tdd_architecture/core/usecase/usecase.dart';
import 'package:flutter_tdd_architecture/features/data/models/user/users_response.dart';
import 'package:flutter_tdd_architecture/features/domain/usecases/usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUser getUser;

  UserBloc({@required GetUser user})
      : assert(user != null),
        getUser = user,
        super(null);

  @override
  UserState get initialState => UserInitial();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is GetUser) {
      yield UserLoading();
      final failureOrUser = await getUser(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrUser);
    }
  }

  Stream<UserState> _eitherLoadedOrErrorState(
    Either<Failure, UsersResponse> failureOrUser,
  ) async* {
    yield failureOrUser.fold(
      (failure) => UserError(message: _mapFailureToMessage(failure)),
      (userResponse) => UserLoaded(usersResponse: userResponse),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}

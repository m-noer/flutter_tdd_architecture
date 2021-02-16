part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserResponseEntity userResponseEntity;

  UserLoaded({
    this.userResponseEntity,
  });

  @override
  List<Object> get props => [userResponseEntity];
}

class UserError extends UserState {
  final String message;
  UserError({
    @required this.message,
  });
  @override
  List<Object> get props => [message];
}

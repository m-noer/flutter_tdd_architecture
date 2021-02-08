import 'package:equatable/equatable.dart';
import '../error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params param);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

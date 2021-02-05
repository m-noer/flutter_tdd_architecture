part of 'tdd_bloc.dart';
abstract class TddState extends Equatable {
  const TddState();
}
class TddInitial extends TddState {
  @override
  List<Object> get props => [];
}

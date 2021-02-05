import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'tdd_event.dart';
part 'tdd_state.dart';
class TddBloc extends Bloc<TddEvent, TddState> {
  TddBloc() : super(TddInitial());
  @override
  Stream<TddState> mapEventToState(
    TddEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}

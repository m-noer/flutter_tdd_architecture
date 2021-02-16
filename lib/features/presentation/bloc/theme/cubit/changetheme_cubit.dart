import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'changetheme_state.dart';

class ChangethemeCubit extends Cubit<ThemeMode> {
  ChangethemeCubit() : super(ThemeMode.system);

  // static final _lightTheme = ThemeData(
  //       primarySwatch: Colors.blue,
  //       visualDensity: VisualDensity.adaptivePlatformDensity,
  //       textTheme: TextTheme(
  //         subtitle2: TextStyle(color: Colors.black),
  //       ),
  //     );

  // static final _darkTheme = ThemeData(
  //       brightness: Brightness.dark,
  //       textTheme: TextTheme(
  //         subtitle2: TextStyle(color: Colors.lightBlue),
  //       ),
  //     );

  void toggleTheme(ThemeMode theme) {
    switch (theme) {
      case ThemeMode.light:
        emit(ThemeMode.light);
        break;
      case ThemeMode.dark:
        emit(ThemeMode.dark);
        break;
      default:
        emit(ThemeMode.system);
    }
    // emit(state == Theme);
  }
}

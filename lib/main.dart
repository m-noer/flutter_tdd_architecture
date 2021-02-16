import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/presentation/bloc/simple_observer.dart';
import 'features/presentation/bloc/theme/cubit/changetheme_cubit.dart';
import 'features/presentation/pages/home/home_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangethemeCubit(),
      child: BlocBuilder<ChangethemeCubit, ThemeMode>(
        builder: (context, theme) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              textTheme: TextTheme(
                headline6: TextStyle(color: Colors.black),
              ),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              textTheme: TextTheme(
                headline6: TextStyle(color: Colors.lightBlue),
              ),
            ),
            themeMode: theme,
            home: HomePage(),
          );
        },
      ),
    );
  }
}

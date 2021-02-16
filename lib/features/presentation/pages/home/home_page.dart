import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd_architecture/features/presentation/bloc/theme/cubit/changetheme_cubit.dart';
import '../../bloc/user/user_bloc.dart';

import '../../../../injection_container.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final userBloc = sl<UserBloc>();
  ThemeMode themeMode = ThemeMode.system;
  final changeThemeBloc = ChangethemeCubit();

  @override
  void initState() {
    super.initState();
    userBloc.add(GetUserEvent());
  }

  Future onRefresh() async {
    userBloc.add(GetUserEvent());
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  void dispose() {
    userBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Users List'),
        ),
        body: BlocProvider<UserBloc>(
          create: (context) => userBloc,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            // color: Colors.blue,
            child: ListView(
              children: [
                ElevatedButton(
                  onPressed: () {
                    userBloc.add(GetUserEvent());
                  },
                  child: Text('Generate'),
                ),
                BlocListener<UserBloc, UserState>(
                  listener: (context, state) {
                    if (state is UserError) {
                      return Text(state.message);
                    } else if (state is UserLoaded) {
                      return Container(
                        child: Text(state.userResponseEntity.data[0].avatar),
                      );
                    }
                  },
                  child: Column(
                    children: [
                      // ElevatedButton(
                      //   child: Text('Change'),
                      //   onPressed: () {
                      //     context.read<ChangethemeCubit>().toggleTheme();
                      //   },
                      // ),
                      DropdownButton(
                        hint: Text('Choose Theme'),
                        value: themeMode,
                        items: [
                          DropdownMenuItem(
                            child: Text('Light'),
                            value: ThemeMode.light,
                          ),
                          DropdownMenuItem(
                            child: Text('Dark'),
                            value: ThemeMode.dark,
                          ),
                          DropdownMenuItem(
                            child: Text('System'),
                            value: ThemeMode.system,
                          ),
                        ],
                        onChanged: (value) {
                          BlocProvider.of<ChangethemeCubit>(context)
                              .toggleTheme(value);
                          themeMode = value;
                        },
                      ),
                      BlocBuilder<UserBloc, UserState>(
                          builder: (context, state) {
                        if (state is UserLoading) {
                          return CircularProgressIndicator();
                        } else if (state is UserLoaded) {
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.userResponseEntity.data.length,
                            itemBuilder: (context, i) {
                              return ListTile(
                                title: Text(
                                  state.userResponseEntity.data[i].firstName,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              );
                            },
                          );
                        } else {
                          return Text('error');
                        }
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

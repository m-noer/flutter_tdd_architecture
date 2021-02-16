import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd_architecture/features/presentation/bloc/user/user_bloc.dart';

import '../../../../injection_container.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: close_sinks
  final userBloc = sl<UserBloc>();

  @override
  void initState() {
    super.initState();
    userBloc.add(GetUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    BlocBuilder<UserBloc, UserState>(builder: (context, state) {
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
                                  state.userResponseEntity.data[i].firstName),
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/app/bloc/app.dart';
import 'package:user_repository/user_repository.dart';
import 'bloc/login.dart';

class LoginPage extends StatelessWidget {
  final UserRepository userRepository;

  LoginPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 避免軟鍵盤把widget頂上去
      resizeToAvoidBottomPadding: false,
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            appBloc: BlocProvider.of<AppBloc>(context),
            userRepository: userRepository,
          );
        },
        child: LoginChildPage(),
      ),
    );
  }
}

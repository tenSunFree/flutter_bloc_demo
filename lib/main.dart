import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/home/home.dart';
import 'package:flutter_bloc_demo/login/bloc/login.dart';
import 'package:flutter_bloc_demo/splash/splash.dart';
import 'package:user_repository/user_repository.dart';
import 'app/bloc/app.dart';

void main() {
  final userRepository = UserRepository();
  runApp(
    BlocProvider<AppBloc>(
      create: (context) {
        // ..操作符是dart的cascade操作符, 對於不關心返回值的鏈接操作很有用, 針對始終返回this
        return AppBloc(userRepository: userRepository)
          ..add(StartLoginPageAppEvent());
      },
      child: MyApp(userRepository: userRepository),
    ),
  );
  setStatusBar();
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;

  MyApp({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter_bloc_demo',
      theme: ThemeData(
        // 光標的顏色
        cursorColor: Color(0xFF1A9589),
      ),
      home: BlocBuilder<AppBloc, AppState>(
        // 透過判斷state來執行對應的行為
        builder: (context, state) {
          if (state is StartHomePageAppState) {
            return HomePage();
          }
          if (state is StartLoginPageAppState) {
            return LoginPage(userRepository: userRepository);
          }
          return SplashPage();
        },
      ),
    );
  }
}

/// 設置StatusBar為透明
void setStatusBar() {
  if (Platform.isAndroid) {
    SystemUiOverlayStyle style = SystemUiOverlayStyle(
      statusBarColor: Color(0xFF757575),
      statusBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(style);
  }
}

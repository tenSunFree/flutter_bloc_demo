import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc_demo/app/bloc/app.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AppBloc appBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.appBloc,
  })  : assert(userRepository != null),
        assert(appBloc != null);

  @override
  LoginState get initialState => InitializeLoginState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is ClickLoginEvent) {
      yield LoadingLoginState();
      try {
        final token = await userRepository.getToken(
          account: event.account,
          password: event.password,
        );
        if (token != null) {
          appBloc.add(StartHomePageAppEvent(token: token));
        } else {
          yield FailureLoginState(
            error: "帳號或密碼錯誤  帳號:0980123456 密碼:abc123",
          );
        }
      } catch (error) {
        yield FailureLoginState(error: error.toString());
      }
    }
  }
}

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class InitializeLoginState extends LoginState {}

class LoadingLoginState extends LoginState {}

class FailureLoginState extends LoginState {
  final String error;

  const FailureLoginState({@required this.error});

  @override
  List<Object> get props => [error];
}

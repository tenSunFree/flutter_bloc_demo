import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class ClickLoginEvent extends LoginEvent {
  final String account;
  final String password;

  const ClickLoginEvent({
    @required this.account,
    @required this.password,
  });

  @override
  List<Object> get props => [account, password];
}

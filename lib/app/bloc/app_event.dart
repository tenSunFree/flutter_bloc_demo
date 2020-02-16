import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class StartLoginPageAppEvent extends AppEvent {}

class StartHomePageAppEvent extends AppEvent {
  final String token;

  const StartHomePageAppEvent({@required this.token});

  @override
  List<Object> get props => [token];
}

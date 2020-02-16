import 'package:equatable/equatable.dart';

abstract class AppState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitializeAppState extends AppState {}

class StartLoginPageAppState extends AppState {}

class StartHomePageAppState extends AppState {}
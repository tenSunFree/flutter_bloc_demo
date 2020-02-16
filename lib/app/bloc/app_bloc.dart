import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:user_repository/user_repository.dart';

import 'app.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  // 用final修飾的變量, 必須在定義時將其初始化, 其值在初始化後不可改變
  final UserRepository userRepository;

  // 使用冒號調用其他構造函數
  AppBloc({@required this.userRepository}) : assert(userRepository != null);

  /// 最初的狀態
  @override
  AppState get initialState => InitializeAppState();

  /// async*: 異步生成器, 通過在方法主體前添加async*可以標記該方法為異步生成器
  /// 異步生成器返回一個Stream對象, 並使用yield語句來傳遞值
  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    if (event is StartLoginPageAppEvent) {
      final bool hasToken = await userRepository.hasToken();
      if (!hasToken) {
        yield StartLoginPageAppState();
      }
    }
    if (event is StartHomePageAppEvent) {
      yield StartHomePageAppState();
    }
  }
}

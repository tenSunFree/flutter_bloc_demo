import 'dart:async';
import 'package:meta/meta.dart';

/// async: 聲明該函數內部有代碼需要延遲執行
class UserRepository {
  Future<String> getToken({
    @required String account,
    @required String password,
  }) async {
    // await: 聲明運算為延遲執行
    await Future.delayed(Duration(seconds: 3));
    if (account == "0980123456" && password == "abc123") {
      return "success";
    } else {
      return null;
    }
  }

  Future<bool> hasToken() async {
    await Future.delayed(Duration(seconds: 3));
    return false;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/login.dart';

class LoginChildPage extends StatefulWidget {
  @override
  State<LoginChildPage> createState() => _LoginChildPageState();
}

class _LoginChildPageState extends State<LoginChildPage> {
  final _accountController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(
        ClickLoginEvent(
          account: _accountController.text,
          password: _passwordController.text,
        ),
      );
    }

    // BlocListener和BlocBuilder類似一樣會去監聽State的變化
    // 兩者的差別在於Listener是用來顯示如SnackBar Dialog的通知, 而Builder是重建整個畫面
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is FailureLoginState) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Color(0xFFC5160F),
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Stack(children: <Widget>[
            state is! LoadingLoginState ? showIconLogin() : Container(),
            Container(
              child: state is! LoadingLoginState
                  ? Column(
                      children: [
                        Flexible(child: Container(), flex: 41),
                        // 帳號 密碼 登入
                        Flexible(
                          child: Container(
                            // color: Color(0x8000A600),
                            child: Center(
                              child: Column(children: [
                                // 帳號
                                showContainer(
                                  "帳號",
                                  _accountController,
                                  "為您的手機號碼",
                                  // 只能輸入數字
                                  WhitelistingTextInputFormatter(
                                    RegExp("[0-9]"),
                                  ),
                                  // 限制長度
                                  10,
                                ),
                                Flexible(child: Container(), flex: 1),
                                // 密碼
                                showContainer(
                                    "密碼",
                                    _passwordController,
                                    "6 - 12 碼英數字",
                                    // 只能輸入英文或數字
                                    WhitelistingTextInputFormatter(
                                      RegExp("[a-zA-Z]|[0-9]"),
                                    ),
                                    // 限制長度
                                    12),
                                Flexible(child: Container(), flex: 3),
                                // 登入
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 12,
                                    right: 12,
                                  ),
                                  child: ButtonTheme(
                                    minWidth: 1000,
                                    height: 46,
                                    child: RaisedButton(
                                      color: Color(0xFFC6160F),
                                      onPressed: state is! LoadingLoginState
                                          ? _onLoginButtonPressed
                                          : null,
                                      child: Text(
                                        "登入",
                                        style: TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                          flex: 30,
                        ),
                        Flexible(child: Container(), flex: 49),
                      ],
                    )
                  : Container(color: Color(0xFFF0F0F0)),
            ),
            state is LoadingLoginState
                ? showCircularProgressIndicator()
                : Container(),
          ]);
        },
      ),
    );
  }
}

Widget showIconLogin() {
  return Image.asset(
    "assets/icons/icon_login.png",
    fit: BoxFit.fill,
  );
}

Widget showContainer(
    String title,
    TextEditingController controller,
    String hintText,
    WhitelistingTextInputFormatter whitelistingTextInputFormatter,
    int lengthLimiting) {
  return Container(
    height: 46,
    margin: EdgeInsets.only(left: 6, right: 6),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.all(
        Radius.circular(4),
      ),
    ),
    child: Row(children: <Widget>[
      Flexible(
        child: Center(
          child: Text(title, style: TextStyle(fontSize: 17)),
        ),
        flex: 15,
      ),
      Flexible(
        child: Container(
          margin: EdgeInsets.only(
            top: 15,
            right: 13,
          ),
          // color: Color(0x80657786),
          child: TextField(
            controller: controller,
            textAlign: TextAlign.right,
            inputFormatters: <TextInputFormatter>[
              // 只能輸入數字
              whitelistingTextInputFormatter,
              // 限制長度
              LengthLimitingTextInputFormatter(lengthLimiting),
            ],
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF373737),
            ),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 0,
                ),
              ),
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: new TextStyle(
                fontSize: 16,
                color: Color(0xFFB2B2B2),
              ),
            ),
            // controller: _inputController
          ),
        ),
        flex: 50,
      ),
    ]),
  );
}

Widget showCircularProgressIndicator() {
  return Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF009283)),
      strokeWidth: 4,
    ),
  );
}

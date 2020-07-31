import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterbasics/service/authentication.dart';
import 'package:flutterbasics/view/DashboardView.dart';
import 'package:flutterbasics/view/LoginView.dart';

enum AuthStatus {
  NOT_DETERMINED,
  LOGGED_IN,
  LOGGED_OUT
}

class RootView extends StatefulWidget {

  RootView({this.baseAuth});

  final BaseAuth baseAuth;

  @override
  _RootViewState createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "A";

  getUserData() async{
    String val =  await widget.baseAuth.currentUser();
    return val;
  }
  @override
  void initState()  {
    super.initState();
//    String userId = getUserData().then((userId) {
//      setState(() {
//        setState(() {
//          authStatus = userId != null ? AuthStatus.LOGGED_IN: AuthStatus.LOGGED_OUT;
//          _userId = userId;
//        });
//      });
//    });

    String userId = null;
    setState(() {
      authStatus = userId != null ? AuthStatus.LOGGED_IN: AuthStatus.LOGGED_OUT;
      _userId = '';
    });

  }

  void logoutCallback() async{
    var res = await widget.baseAuth.signOut();
    setState(() {
      authStatus = AuthStatus.LOGGED_OUT;
      _userId = "";
    });
  }

  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  void loginCallback() async{
    var userId = await widget.baseAuth.currentUser();

    setState(() {
      authStatus = AuthStatus.LOGGED_IN;

      setState(() {
        authStatus = AuthStatus.LOGGED_IN;
        _userId = userId;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    switch(authStatus) {
      case AuthStatus.LOGGED_OUT:
        return new LoginView(loginCallback: loginCallback, auth: widget.baseAuth);
        break;
      case AuthStatus.NOT_DETERMINED:
        return buildWaitingScreen();
        break;
      case AuthStatus.LOGGED_IN:
        if(_userId.length > 0 && _userId != null) {
          return new DashboardView(
            userId: _userId,
            logoutCallback:logoutCallback
          );
        }else
          return buildWaitingScreen();
        break;
        default:
          return buildWaitingScreen();
    }
    return Container();
  }
}

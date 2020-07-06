import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  LoginView({@required  this.loginCallback, Key key}): super(key:key);

  final Function loginCallback;

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  validateAndSubmit () {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        child: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'UserName'
            ),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Password'
            ),
          ),
          SizedBox(height: 20),
          showPrimaryButton()
        ],
      ),
        padding: EdgeInsets.all(30.0),
      )
    );
  }

  Widget showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.blue,
            child: new Text('Login',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: () {
              widget.loginCallback();
            },
          ),
        ));
  }
}

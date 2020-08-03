import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutterbasics/service/authentication.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginView extends StatefulWidget {
  LoginView({@required  this.loginCallback, this.auth ,Key key}): super(key:key);

  final BaseAuth auth;
  final Function loginCallback;

  @override
  _LoginViewState createState() => _LoginViewState();
}

class EmailFieldValidator {
  static String validate(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if(value.isEmpty)
      return 'Email can\'t be empty';
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }
}

class PasswordFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Password can\'t be empty' : null;
  }
}

enum FormType {
  login,
  register
}

class _LoginViewState extends State<LoginView> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = new TextEditingController();

  bool _autoValidate = false;
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  String _email = null;
  String _password = null;
  String _confirmPassword = null;
  FormType _formType = FormType.login;

  validateFormNSave() {
    final FormState form = formKey.currentState;
    if(form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  googleSignIn() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount googleUser =
      await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      // get the credentials to (access / id token)
      // to sign in via Firebase Authentication
      final AuthCredential credential =
      GoogleAuthProvider.getCredential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken
      );

      String userId = (await widget.auth.signInWithCredential(credential));
      print('google singin userID $userId');
      widget.loginCallback();
    } catch(e) {
      print('Error - $e');
      print('Error message - ${e.message}');
      showAlert(e.message);
    }
  }

   initiateFacebookLogin() async {
//    var facebookLogin = FacebookLogin();
//    var facebookLoginResult = await facebookLogin.logIn(['email']);
//    print('facebookLoginResult - $facebookLoginResult');
//    switch (facebookLoginResult.status) {
//      case FacebookLoginStatus.error:
//        print("Error");
//        //onLoginStatusChanged(false);
//        break;
//      case FacebookLoginStatus.cancelledByUser:
//        print("CancelledByUser");
//        //onLoginStatusChanged(false);
//        break;
//      case FacebookLoginStatus.loggedIn:
//        print("LoggedIn");
//        widget.loginCallback();
//        break;
//    }
  }

  initateTwitterLogin() {

  }

  validateAndSubmit () async{
    if(validateFormNSave()) {
      setState(() {
        _autoValidate = true;
      });
      try {
        final FirebaseAuth _auth = FirebaseAuth.instance;
        if (_formType == FormType.login) {
          String userId = await widget.auth.signInWithEmailAndPassword(_email, _password);
          print('Signed up user: $userId');
          widget.loginCallback();
        } else{
          String userId = await widget.auth.createUserWithEmailAndPassword(_email, _password);
          print('Signed up user: $userId');
          showAlert('User added successfully!!');
        }
      }catch(e) {
        print('Error - $e');
        print('Error message - ${e.message}');
        showAlert(e.message);
      }
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  showAlert(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context)
        {
          return AlertDialog(
            title: Text("Error"),
            content: Text(message),
            actions: [
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        padding: EdgeInsets.all(15),
        child: Form(
          autovalidate: _autoValidate,
          key: formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                Text(_formType == FormType.register ? 'Register' : 'Sign In',
                    style: new TextStyle(fontSize: 20.0, color: Colors.teal,decoration: TextDecoration.underline )),
                showEmailInput(),
                SizedBox(height: 20),
                showPasswordInput(),
                SizedBox(height: (_formType == FormType.register) ? 20: 5),
                showConfirmPassword(),
                SizedBox(height: 5),
                showPrimaryButton(),
                showOtherButtonsImages()
                //showOtherButtons()
              ],
        ),
            ),
          ),
        ),
      )
    );
  }

  Widget showOtherButtonsImages() {
    return Container(
      alignment: Alignment.center,

      child: Column(
        children: [
          RaisedButton(
            onPressed: () => {},
            padding: EdgeInsets.only(top: 3.0, bottom: 3.0, left: 3.0),
            color: const Color(0xFFFFFFFF),
            child: Row(
                mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/google.jpg', height: 30.0,),
                new Container(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: new Text(
                      "Sign in with Google",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    )
                ),
              ]
            ),
          ),
          SizedBox(height: 10),
          RaisedButton(
            onPressed: () => {},
            padding: EdgeInsets.only(top: 3.0, bottom: 3.0, left: 3.0),
            color: const Color(0xFFFFFFFF),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/fb.jpg', height: 30.0,),
                new Container(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: new Text(
                      "Sign in with Facebook",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    )
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          RaisedButton(
            onPressed: () => {},
            padding: EdgeInsets.only(top: 3.0, bottom: 3.0, left: 3.0),
            color: const Color(0xFFFFFFFF),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/twitter.png', height: 30.0,),
                new Container(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: new Text(
                      "Sign in with Twitter",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    )
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget showOtherButtons() {
    return Column(
        children: <Widget>[
          FlatButton(
            child: Text('Sign In With Google',
              style: TextStyle(fontSize: 20.0, color: Colors.teal),),
            onPressed: googleSignIn,
          ),
          FlatButton(
            child: Text('Sign In With Facebook',
              style: TextStyle(fontSize: 20.0, color: Colors.teal),),
            onPressed: initiateFacebookLogin,
          ),
          FlatButton(
            child: Text('Sign In With Twitter',
              style: TextStyle(fontSize: 20.0, color: Colors.teal),),
            onPressed: initateTwitterLogin,
          )
        ]);
  }

  Widget showEmailInput() {
    return TextFormField(
      key: Key('email'),
      keyboardType: TextInputType.emailAddress,
      validator: EmailFieldValidator.validate,
      onSaved: (String value) => _email = value,
      decoration: InputDecoration(
          hintText: 'Email',
          prefixIcon: new Icon(
            Icons.mail,
            color: Colors.grey,
          )
      ),
    );
  }

  Widget showPasswordInput() {
    return TextFormField(
      controller: _passwordController,
      key: Key('password'),
      obscureText: !this._showPassword,
      validator: PasswordFieldValidator.validate,
      onSaved: (String value) => _password = value,
      decoration: InputDecoration(
          hintText: 'Password',
        prefixIcon: new Icon(
          Icons.lock,
          color: Colors.grey,
        ),
        suffixIcon: IconButton(
          icon: Icon(Icons.remove_red_eye),
          color: this._showPassword ? Colors.blue: Colors.grey,
          onPressed: () {
            setState(() {
              this._showPassword = !this._showPassword;
            });
          },
        )
      ),
    );
  }

  Widget showPrimaryButton() {
    if(_formType == FormType.login) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: Colors.teal)
              ),
              child: Text('Register',
                style: TextStyle(fontSize: 15.0, color: Colors.teal),),
              onPressed: moveToRegister,
            ),
            RaisedButton(
              elevation: 0.0,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(8.0)),
              color: Colors.teal,
              child: new Text('Login',
                  style: new TextStyle(fontSize: 20.0, color: Colors.white)),
              onPressed: () {
                validateAndSubmit();
              },
            )
          ]);
    } else {
      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: Colors.teal)
              ),
              child: Text('Sign In',
                style: TextStyle(fontSize: 15.0, color: Colors.teal),),
              onPressed: moveToLogin,
            ),
            RaisedButton(
              elevation: 5.0,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0)),
              color: Colors.teal,
              child: new Text('Register',
                  style: new TextStyle(fontSize: 20.0, color: Colors.white)),
              onPressed: () {
                validateAndSubmit();
              },
            )
          ]);
    }
  }

  Widget showConfirmPassword() {
    if(_formType == FormType.register) {
      return Column(
          children: <Widget>[
            TextFormField(
                key: Key('confirm_password'),
                obscureText: !this._showConfirmPassword,
                validator: (val){
                  print(_passwordController.text);
                  if(val.isEmpty)
                    return 'Empty';
                  if(val != _passwordController.text)
                    return 'Passwords Do Not Match';
                  return null;
                },
                onSaved: (String value) => _confirmPassword = value,
                decoration: InputDecoration(
                hintText: 'Confirm Password',
                prefixIcon: new Icon(
                  Icons.lock,
                  color: Colors.grey,
                ),
                suffixIcon: IconButton(
                icon: Icon(Icons.remove_red_eye),
                color: this._showConfirmPassword ? Colors.blue: Colors.grey,
                onPressed: () {
                  setState(() {
                  this._showConfirmPassword = !this._showConfirmPassword;
                  });
                },
              )
            ),
          ),
      ]);
    } else {
      return SizedBox(height: 1);
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
      _autoValidate = false;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
      _autoValidate = false;
    });
  }
}

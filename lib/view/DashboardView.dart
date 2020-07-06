import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  DashboardView({Key key, this.userId, this.logoutCallback})
      : super(key: key);

  final VoidCallback logoutCallback;
  final String userId;

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  signOut() {
    try {
      //await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard'
        ),
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.exit_to_app), onPressed: signOut)
        ],
      ),
      body: Text('Welcome'),
    );
  }
}

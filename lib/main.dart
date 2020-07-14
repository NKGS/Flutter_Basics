import 'package:flutter/material.dart';
import 'package:flutterbasics/service/authentication.dart';
import 'package:flutterbasics/view/RootView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Basics',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RootView(baseAuth: new Authentication()),
    );
  }
}

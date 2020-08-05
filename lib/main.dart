import 'package:flutter/material.dart';
import 'package:flutterbasics/service/authentication.dart';
import 'package:flutterbasics/view/RootView.dart';
import 'package:flutterbasics/view/SearchProducts.dart';

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
        primarySwatch: Colors.teal,
        accentColor: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.teal,
          textTheme: ButtonTextTheme.primary,
        ),
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          button: TextStyle(fontSize: 14.0, color:Colors.teal)
        ),
      ),
      home: RootView(baseAuth: new Authentication()),
      // routes: <String, WidgetBuilder>{
      //   '/': (context) => RootView(baseAuth: new Authentication()),
      //   '/SearchProducts': (context) => SearchProducts(),
      // },
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(settings: settings, builder: (context)=> RootView(baseAuth: new Authentication()));
            break;
          case '/SearchProducts':
            return MaterialPageRoute(settings:settings, builder: (context)=> SearchProducts());
            break;
        }
      },
    );
  }
}

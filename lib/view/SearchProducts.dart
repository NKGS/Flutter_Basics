import 'package:flutter/material.dart';
import 'package:flutterbasics/utils/MyDrawer.dart';

class SearchProducts extends StatefulWidget {
  @override
  _SearchProductsState createState() => _SearchProductsState();
}

class _SearchProductsState extends State<SearchProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search Products'
        ),
      ),
      drawer: MyDrawer(),
      body: Text('Welcommmee to search Products'),
    );
  }
}
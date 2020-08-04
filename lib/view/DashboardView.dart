import 'package:flutter/material.dart';
import 'package:flutterbasics/utils/MyDrawer.dart';

class DashboardView extends StatefulWidget {
  DashboardView({Key key, this.userId, this.logoutCallback})
      : super(key: key);

  final VoidCallback logoutCallback;
  final String userId;

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {

  final List<ListItem> items = getProductCategories();
  
  static getProductCategories() {
    List<ListItem> items = new List<ListItem>();
    // var val = [{
    //   key: "Food Items",
    //   value: "Select from variety of super foods",
    //   id: 1
    // },{
    //   key: "Beauty Products",
    //   value: "Select from range of beauty products",
    //   id: 2
    // },{
    //   key: "Kalverts",
    //   value: "Select from variety of Kalverts juices",
    //   id: 3
    // },{
    //   key: "Other Items",
    //   value: "Select the required items",
    //   id: 4
    // }]
    items.add(MessageItem("Food Items", "Select from variety of super foods", 1));
    items.add(MessageItem("Beauty Products", "Select from range of beauty products", 2));
    items.add(MessageItem("Kalverts", "Select from variety of Kalverts juices", 3));
    items.add(MessageItem("Other Items", "Select the required items", 4));

    return items;
  }
  
  signOut() {
    try {
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
          'Product Category'
        ),
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.exit_to_app), onPressed: signOut)
        ],
      ),
      drawer: MyDrawer(),
      body: ListView.builder(
          // Let the ListView know how many items it needs to build.
          itemCount: items.length,
          // Provide a builder function. This is where the magic happens.
          // Convert each item into a widget based on the type of item it is.
          itemBuilder: (context, index) {
            final item = items[index];

            return ListTile(
              title: item.buildTitle(context),
              subtitle: item.buildSubtitle(context),
            );
          },
        ),
    );
  }
}

// The base class for the different types of items the list can contain.
abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);
}

/// A ListItem that contains data to display a heading.
class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);

  Widget buildTitle(BuildContext context) {
    return Text(
      heading,
      style: Theme.of(context).textTheme.headline5,
    );
  }

  Widget buildSubtitle(BuildContext context) => null;
}

/// A ListItem that contains data to display a message.
class MessageItem implements ListItem {
  final String sender;
  final String body;
  final int id;

  MessageItem(this.sender, this.body, this.id);

  Widget buildTitle(BuildContext context) => Text(sender);

  Widget buildSubtitle(BuildContext context) => Text(body);
}
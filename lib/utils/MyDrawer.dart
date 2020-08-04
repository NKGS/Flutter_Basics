import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {

  ScrollController controller = ScrollController();
  ScrollPhysics physics = ScrollPhysics();


  @override
  Widget build(BuildContext context) {

    // Widget logout = IconButton(
    //     icon: Icon(Icons.exit_to_app),
    //     onPressed: () => {});

    Widget logout = Column(
        children: [
          Divider(height: 3,color: Colors.blueGrey),
          ListTile(
                title: Text('Logout'),
                onTap: () {},
                trailing: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 44,
                    minHeight: 44,
                    maxWidth: 44,
                    maxHeight: 44,
                  ),
                  child: Icon(Icons.exit_to_app)
                ),
              )
        ]
    );

    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListView(
            controller: controller,
            physics: physics,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Text('Flutter Basics', style: new TextStyle(
                  color: Colors.white
                )),
                    decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
              
              ),
              ListTile(
                title: Text('View Categories'),
                onTap: () {},
              ),
              Divider(height: 1.0, color: Colors.blueGrey,),
              ListTile(
                title: Text('Search Products'),
                onTap: () {},
              ),
              Divider(height: 1.0, color: Colors.blueGrey,),
              ListTile(
                title: Text('View Cart'),
                onTap: () {},
              ),
              Divider(height: 1.0, color: Colors.blueGrey,),
              ListTile(
                title: Text('Add Address'),
                onTap: () {},
              ),
              Divider(height: 1.0, color: Colors.blueGrey,)
            ],
          ),
          this.isListLarge() ? Container() : logout 
        ],
      ),
      
    );
  }

   bool isListLarge() {
    return controller.positions.isNotEmpty && physics.shouldAcceptUserOffset(controller.position);
  }
}
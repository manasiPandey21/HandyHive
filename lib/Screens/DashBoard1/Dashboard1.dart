import 'package:flutter/material.dart';


import '../../dashBoardPage/Models.dart';
import '../../dashBoardPage/widgets.dart';


class dashBoard extends StatefulWidget {
  const dashBoard({super.key});

  @override
  State<dashBoard> createState() => _dashBoardState();
}

class _dashBoardState extends State<dashBoard> {
  @override
  Widget build(BuildContext context) {
    const iconSize = 50;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        leading: PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                child: Column(
                  children: [
                     SizedBox(
                      height: 10,
                    ),
                    Text("Menu",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                     SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [Icon(Icons.filter,color: Colors.pinkAccent,), Text("Filter")],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [Icon(Icons.sort,color: Colors.pinkAccent), Text("Sort")],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [Icon(Icons.edit,color: Colors.pinkAccent), Text("Edit work choice")],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [Icon(Icons.feedback,color: Colors.pinkAccent), Text("feedback")],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(Icons.privacy_tip,color: Colors.pinkAccent),
                        Text("Privacy Policy")
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [Icon(Icons.book,color: Colors.pinkAccent),Text("Terms & conditions")],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [Icon(Icons.help,color: Colors.pinkAccent), Text("Help")],
                    ),
                     SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ];
          },
        ),

        //leading: Icon(Icons.menu),
        title: Center(child: Text("Dashboard")),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notification_add),
            onPressed: () {},
          ),
        ],
      ),
      body:  Card(
        child: ListView.builder(
          
              itemCount: CatalogModel.items.length,
              itemBuilder: (context, index) {
                return ItemWidget(item: CatalogModel.items[index]);
              }),
      ),
      bottomNavigationBar: BottomNavigationBar(
          //  backgroundColor: Colors.pinkAccent,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.pinkAccent,
              ),
              label: "Dashboard",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.message,
                color: Colors.pinkAccent,
              ),
              label: "chat",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_bag,
                color: Colors.pinkAccent,
              ),
              label: "My Clients",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.face_outlined,
                color: Colors.pinkAccent,
              ),
              label: "Me",
            ),
          ]),
    );
  }
}

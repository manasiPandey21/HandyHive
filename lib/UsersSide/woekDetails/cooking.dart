import 'package:flutter/material.dart';
import 'package:handyhive/Screens/ProfilePage/Profile.dart';

import '../../dashBoardPage/Models.dart';
import '../../dashBoardPage/widgets.dart';

class Cooking extends StatefulWidget {
  const Cooking({super.key});

  @override
  State<Cooking> createState() => _CookingState();
}

class _CookingState extends State<Cooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Results for your cooking search")),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Ink(
        child: Card(
          child: ListView.builder(
              itemCount: CatalogModel.items.length,
              itemBuilder: (context, index) {
                
                return ItemWidget(item: CatalogModel.items[index]);
              }),
            
              
        ),
        
      ),
    );
  }
}

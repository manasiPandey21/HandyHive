import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class LoadScreen extends StatefulWidget {
  @override
  _LoadScreenState createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> {
  @override
  void initState() {
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Container(
      
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
            child: Container(
          margin: EdgeInsets.only(left: 30, right: 30),
          alignment: Alignment.center,
          child: Image.asset(
            
            "assets/logoooo.png",
            height: height / 4.5,
            width: width / 1.5,
          ),
        ))));
  }
}
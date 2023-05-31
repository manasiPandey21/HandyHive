import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
            child: Container(
          margin: EdgeInsets.only(left: 30, right: 30),
          alignment: Alignment.center,
          child: Image.asset(
            "assets/images/logoanimation.gif",
            height: height / 4.5,
            width: width / 2,
          ),
        )));
  }
}
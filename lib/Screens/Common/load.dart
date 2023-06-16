import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';

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
          margin: EdgeInsets.only(left: 50, right: 50,top: 50,bottom: 50),
          alignment: Alignment.center,
          child:
          Lottie.network(
                 'https://assets6.lottiefiles.com/packages/lf20_p8bfn5to.json'
               ),
          ) 
        )));
  }
}
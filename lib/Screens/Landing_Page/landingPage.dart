import 'package:flutter/material.dart';
import 'package:handyhive/Screens/authenticate/Sign_up.dart';
import 'package:lottie/lottie.dart';

class landing extends StatefulWidget {
  const landing({super.key});

  @override
  State<landing> createState() => _landingState();
}

class _landingState extends State<landing> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
          Image.asset(
            "assets/554.jpg",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
    ),
    Scaffold(
      backgroundColor: Colors.transparent,
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("Please choose your role",style: TextStyle(fontSize: 35,fontWeight: FontWeight.w900),),
            Lottie.network('https://assets5.lottiefiles.com/packages/lf20_pWTOxQsYjN.json'),
            ElevatedButton(onPressed: (){
              Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Sign_up(),
              ),
            );
            }, child: Text("Service Provider",style: TextStyle(fontSize: 20),),style: ElevatedButton.styleFrom(
             backgroundColor: Colors.black87,
              minimumSize: Size(200, 60) ,
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)
            ),),),
            SizedBox(
              height: 50,
             ),
             ElevatedButton(onPressed: (){
              Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Sign_up(),
              ),
            );
             }, child: Text("User",style: TextStyle(fontSize: 20),),style: ElevatedButton.styleFrom(
             backgroundColor: Colors.black87,
             minimumSize: Size(200, 60) ,
             shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)
            ))),
             SizedBox(
              height: 100,
             )
          ],
        ),
      ),
    )],
    );
  }
}

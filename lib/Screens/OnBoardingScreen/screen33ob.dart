import 'package:flutter/material.dart';
import 'package:handyhive/Screens/Landing_Page/landingPage.dart';
class onBoardingThird extends StatefulWidget {
  const onBoardingThird({super.key});

  @override
  State<onBoardingThird> createState() => _onBoardingThirdState();
}

class _onBoardingThirdState extends State<onBoardingThird> {
  @override
  Widget build(BuildContext context) {
     final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          

                      SizedBox(height: height/7),



                      Container(
                          alignment: Alignment.center,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // SizedBox(height: 10),
                                Text("Let's start with HANDYHIVE\n",
                                    style: const TextStyle(
                                        color: const Color(0xfffaf5f0),
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Graphik",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 33.8),
                                    textAlign: TextAlign.center),
                                SizedBox(height: height/12),
                                Center(
                                  child: Image(
                                    image: AssetImage('assets/cleaning.png',),
                                    width: 300,
                                  )
                                  
                                ),
                                SizedBox(height: height/10),
                                Text("For more Information,please read terms & conditions and privacy policy",
                                    style: const TextStyle(
                                        color: const Color(0xfffaf5f0),
                                        // fontWeight: FontWeight.w700,
                                        fontFamily: "Graphik",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 16),
                                    textAlign: TextAlign.center),
                                    SizedBox(height: 20,),
                                 ElevatedButton(onPressed: (){
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => landing (),
                                      ),
                                    );
                                 }, child: Text("Let's start",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.pinkAccent),
                                    ),
                                    style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white),
                                    )

                              ]
                              )
                              ),

        ],
      ),
    );;;
  }
}
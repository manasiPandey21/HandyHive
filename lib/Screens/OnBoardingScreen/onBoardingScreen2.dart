import 'package:flutter/material.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: height / 7),
          Container(
              alignment: Alignment.center,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // SizedBox(height: 10),
                    Text(
                        "We will help you by providing all sought of services with trust\n",
                        style: const TextStyle(
                            color: const Color(0xfffaf5f0),
                            fontWeight: FontWeight.w700,
                            fontFamily: "Graphik",
                            fontStyle: FontStyle.normal,
                            fontSize: 33.8),
                        textAlign: TextAlign.center),
                    SizedBox(height: height / 12),
                    Center(
                        child: Image(
                      image: AssetImage(
                        'assets/garden.png',
                      ),
                      width: 300,
                    )),
                    SizedBox(height: height / 10),
                    Text(
                        "From kitchen chores to cleaning,we have eveything for you.",
                        style: const TextStyle(
                            color: const Color(0xfffaf5f0),
                            // fontWeight: FontWeight.w700,
                            fontFamily: "Graphik",
                            fontStyle: FontStyle.normal,
                            fontSize: 16),
                        textAlign: TextAlign.center),
                  ])),
        ],
      ),
    );
    ;
  }
}

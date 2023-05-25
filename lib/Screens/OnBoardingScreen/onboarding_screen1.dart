import 'package:flutter/material.dart';

class OnboardingFirst extends StatefulWidget {
  OnboardingFirst({key}) : super(key: key);

  @override
  _OnboardingFirstState createState() => _OnboardingFirstState();
}

class _OnboardingFirstState extends State<OnboardingFirst> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
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
                      Text("Looking for helping hands?\n",
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
                          'assets/chef.png',
                        ),
                        width: 300,
                      )),
                      SizedBox(height: height / 10),
                      Text("Let's together make this easy for you!",
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
      ),
    );
  }
}

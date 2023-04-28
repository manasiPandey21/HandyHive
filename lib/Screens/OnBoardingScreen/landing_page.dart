import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import '../User/user_registration_page1.dart';
import '../Worker/worker_registration_page1.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
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
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Please choose your role",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900),
                ),
                Lottie.network(
                    'https://assets5.lottiefiles.com/packages/lf20_pWTOxQsYjN.json'),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const WorkerRegistrationPage1(),
                      ),
                    );
                  },
                  child: Text(
                    "Service Provider",
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    minimumSize: Size(200, 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const UserRegistrationPage1(),
                        ),
                      );
                    },
                    child: Text(
                      "User",
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black87,
                        minimumSize: Size(200, 60),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)))),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

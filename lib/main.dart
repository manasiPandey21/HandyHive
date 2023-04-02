

import 'package:flutter/material.dart';
import 'package:handyhive/Screens/DashBoard1/Dashboard1.dart';
import 'package:handyhive/Screens/Landing_Page/landingPage.dart';
import 'package:handyhive/Screens/OnBoardingScreen/screen1ob.dart';
import 'package:handyhive/Screens/OnBoardingScreen/welcomepage.dart';
import 'package:handyhive/Screens/ProfilePage/Profile.dart';
import 'package:handyhive/Screens/WorkPage/workPage.dart';

import 'Screens/OnBoardingScreen/screen2ob.dart';
import 'Screens/OnBoardingScreen/screen3ob.dart';
import 'Screens/authenticate/Sign_up.dart';
import 'Screens/authenticate/otp.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: "welcome",
    routes: {
      "work page":((context) => WorkPages()),//done
      "Profile page":(context) => ProfilePage(),
      "phone": (context) => Sign_up(),//done
      "otp": (context) => MyOtp(),//done
      "landing":(context) => landing(),
      "dashboard1":((context) => dashBoard()),
      "boarding1":(context) => OnboardingFirst(),//done
      "boarding2":(context) => onBoardingSecond(),//done
      "boarding3":(context) => onBoardingThird(),//done
      "welcome":(context)=>Welcomepage()//done
    },
  ));
}

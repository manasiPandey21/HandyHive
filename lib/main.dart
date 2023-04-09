

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:handyhive/Chatpage/chatpage.dart';
import 'package:handyhive/Screens/DashBoard1/Dashboard1.dart';
import 'package:handyhive/Screens/Helpdesk/helpdesk.dart';
import 'package:handyhive/Screens/Landing_Page/landingPage.dart';
import 'package:handyhive/Screens/OnBoardingScreen/screen11ob.dart';
import 'package:handyhive/Screens/OnBoardingScreen/welcomepage.dart';
import 'package:handyhive/Screens/ProfilePage/Profile.dart';
import 'package:handyhive/Screens/WorkPage/workPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:handyhive/UsersSide/userDashBoard.dart';
import 'package:handyhive/UsersSide/userProfile.dart';
import 'package:handyhive/UsersSide/woekDetails/cooking.dart';

import 'Screens/OnBoardingScreen/screen2ob.dart';
import 'Screens/OnBoardingScreen/screen33ob.dart';
import 'Screens/authenticate/Sign_up.dart';
import 'Screens/authenticate/otp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: "dashboard2",
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
      "welcome":(context)=>Welcomepage(),//done
       "chat":(context)=>chatpage(),
        "Profile page2":(context) => ProfilePage2(),
          "helpdesks":(context)=>helpdesk(),
           "dashboard2":((context) =>dashboardUsers()),
            "cooking":(context)=>Cooking(),

    },
  ));
}

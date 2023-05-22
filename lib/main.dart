import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:handyhive/Provider/users_provider.dart';
import 'package:handyhive/Screens/OnBoardingScreen/onboarding_screen1.dart';
import 'package:handyhive/Screens/User/user_registration_page1.dart';
import 'package:handyhive/Screens/User/WorkDetails/cooking.dart';
import 'package:provider/provider.dart';
import 'Provider/auth.dart';
import 'Provider/workers_provider.dart';
import 'Screens/Common/chatpage.dart';
import 'Screens/Common/helpdesk.dart';
import 'Screens/OnBoardingScreen/landing_page.dart';
import 'Screens/OnBoardingScreen/onboarding_screen2.dart';
import 'Screens/OnBoardingScreen/onboarding_screen3.dart';
import 'Screens/OnBoardingScreen/welcome_page.dart';
import 'Screens/User/user_dashboard.dart';

import 'Screens/Worker/worker_dashboard.dart';
import 'Screens/Worker/worker_registration_page1.dart';
import 'Screens/Worker/worker_registration_page2.dart';
import 'Screens/Authentication/login.dart';
import 'Screens/Authentication/otp.dart';
import 'Screens/User/user_edit_profile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
       ChangeNotifierProvider(
      create: (context) => WorkersProvider(),
       ),
      ChangeNotifierProvider<Auth>(
        create: (_) => Auth(),
      ),
     
      ChangeNotifierProvider<UsersProvider>(
        create: (_) => UsersProvider(),
      ),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "welcome",
      routes: {
        
        "work page": ((context) => WorkerRegistrationPage2()), //done
        "Profile page": (context) => WorkerRegistrationPage1(),
        "phone": (context) => Login(), //done
        "otp": (context) => MyOtp(), //done
        "LandingPage": (context) => LandingPage(),
        "dashboard1": ((context) => WorkerDashBoard()),
        "boarding1": (context) => OnboardingFirst(), //done
        "boarding2": (context) => OnBoardingSecond(), //done
        "boarding3": (context) => OnBoardingThird(), //done
        "welcome": (context) => WelcomePage(), //done
        "chat": (context) => ChatPage(),
        "Profile page2": (context) => UserRegistrationPage1(),
        "HelpDesks": (context) => HelpDesk(),
        "dashboard2": ((context) => UserDashBoard()),
        "cooking": (context) => Cooking(),
        "user_edit_profile":(context) => UserEditProfile (),
      },
    ),
  ));
}

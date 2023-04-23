import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:handyhive/Provider/users_provider.dart';
import 'package:handyhive/Screens/OnBoardingScreen/LandingPage.dart';
import 'package:handyhive/Screens/OnBoardingScreen/onBoardingScreen1.dart';
import 'package:handyhive/Screens/User/user_registration_page1.dart';
import 'package:handyhive/Screens/User/WorkDetails/cooking.dart';
import 'package:provider/provider.dart';
import 'Provider/auth.dart';
import 'Provider/workers_provider.dart';
import 'Screens/Common/chatpage.dart';
import 'Screens/Common/helpdesk.dart';
import 'Screens/OnBoardingScreen/onBoardingScreen2.dart';
import 'Screens/OnBoardingScreen/onBoardingScreen3.dart';
import 'Screens/OnBoardingScreen/welcomePage.dart';
import 'Screens/User/userDashBoard.dart';
import 'Screens/Worker/workerDashBoard.dart';
import 'Screens/Worker/worker_registration_page1.dart';
import 'Screens/Worker/worker_registration_page2.dart';
import 'Screens/Authentication/Sign_up.dart';
import 'Screens/Authentication/otp.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<Auth>(
        create: (_) => Auth(),
      ),
      ChangeNotifierProvider<WorkersProvider>(
        create: (_) => WorkersProvider(),
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
        "phone": (context) => Sign_up(), //done
        "otp": (context) => MyOtp(), //done
        "LandingPage": (context) => LandingPage(),
        "dashboard1": ((context) => workerDashBoard()),
        "boarding1": (context) => OnboardingFirst(), //done
        "boarding2": (context) => OnBoardingPage(), //done
        "boarding3": (context) => OnBoardingThird(), //done
        "welcome": (context) => WelcomePage(), //done
        "chat": (context) => ChatPage(),
        "Profile page2": (context) => UserRegistrationPage1(),
        "HelpDesks": (context) => HelpDesk(),
        "dashboard2": ((context) => UserDashBoard()),
        "cooking": (context) => Cooking(),
      },
    ),
  ));
}

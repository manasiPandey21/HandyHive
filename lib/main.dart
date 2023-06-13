import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:handyhive/Models/workers.dart';
import 'package:handyhive/Provider/users_provider.dart';
import 'package:handyhive/Screens/Common/splashScreen.dart';
import 'package:handyhive/Screens/OnBoardingScreen/onboarding_screen1.dart';
import 'package:handyhive/Screens/User/user_registration_page1.dart';
import 'package:provider/provider.dart';
import 'Provider/auth.dart';
import 'Provider/workers_provider.dart';
import 'Screens/Common/chatpage.dart';
import 'Screens/Common/helpdesk.dart';
import 'Screens/OnBoardingScreen/landing_page.dart';
import 'Screens/OnBoardingScreen/onboarding_screen2.dart';
import 'Screens/OnBoardingScreen/onboarding_screen3.dart';
import 'Screens/OnBoardingScreen/welcome_page.dart';
import 'Screens/User/user_bottom_nav.dart';
import 'Screens/User/user_dashboard.dart';

import 'Screens/Worker/worker_bottom_nav.dart';
import 'Screens/Worker/worker_dashboard.dart';
import 'Screens/Worker/worker_registration_page1.dart';
import 'Screens/Worker/worker_registration_page2.dart';
import 'Screens/Authentication/login.dart';
import 'Screens/Authentication/otp.dart';
import 'Screens/User/user_edit_profile.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MultiProvider(
//     providers: [
// ChangeNotifierProvider(
//   create: (context) => WorkersProvider(),
// ),
// ChangeNotifierProvider<Auth>(
//   create: (_) => Auth(),
// ),
// ChangeNotifierProvider<UsersProvider>(
//   create: (_) => UsersProvider(),
// ),
//     ],
//     child: MaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: "welcome",
//       routes: {
//         "work page": ((context) => WorkerRegistrationPage2()), //done
//         "Profile page": (context) => WorkerRegistrationPage1(),
//         "phone": (context) => Login(), //done
//         "otp": (context) => MyOtp(), //done
//         "LandingPage": (context) => LandingPage(),
//         "dashboard1": ((context) => WorkerDashBoard()),
//         "boarding1": (context) => OnboardingFirst(), //done
//         "boarding2": (context) => OnBoardingSecond(), //done
//         "boarding3": (context) => OnBoardingThird(), //done
//         "welcome": (context) => WelcomePage(), //done
//         "chat": (context) => ChatPage(),
//         "Profile page2": (context) => UserRegistrationPage1(),
//         "HelpDesks": (context) => HelpDesk(),
//         "dashboard2": ((context) => UserDashBoard()),
//         "user_edit_profile": (context) => UserEditProfile(),
// //       },
//     ),
//   ));
// }
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIOverlays(
      [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Init.instance.initialize(context),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(home: SplashScreen());
        } else {
          return MultiProvider(
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
              title: 'HandyHive',
              theme: ThemeData(
                primaryColor: Colors.pinkAccent,
              ),
              home: getHome(snapshot.data),
              routes: {
                "work page": ((context) => WorkerRegistrationPage2()), //done
                "Profile page": (context) => WorkerRegistrationPage1(),
                "phone": (context) => Login(), //done
                "LandingPage": (context) => LandingPage(),
                
                "boarding1": (context) => OnboardingFirst(), //done
                "boarding2": (context) => OnBoardingSecond(), //done
                "boarding3": (context) => OnBoardingThird(), //done
                "welcome": (context) => WelcomePage(), //done
                "chat": (context) => ChatPage(),
                "Profile page2": (context) => UserRegistrationPage1(),
                "HelpDesks": (context) => HelpDesk(),
                "user_edit_profile": (context) => UserEditProfile(),
              },
            ),
          );
        }
      },
    );
  }

  Widget getHome(int authLevel) {
    switch (authLevel) {
      case -1:
        return Login();
      // break;
      case 0:
        return WelcomePage();
      // break;
      case 1:
        return  UserBottomNavigation();
      // break;
      case 2:
        return  WorkerBottomNavigation();
      // break;
      default:
        return Center(child: Text('Something Went wrong : ((((('));
    }
  }
}

class Init {
  Init._();
  static final instance = Init._();

  Future<int?> initialize(BuildContext context) async {
    await Firebase.initializeApp();
    if (!Auth.isAuth) {
      //int x = await checkFirstSeen();
      // print(x);
      //   if (x == 1) {
      //     return 0;
      //   } else
           return -1;
       } else {
      Auth.setUid();
      var userdocumentSnapshot = await FirebaseFirestore.instance
          .collection('USERS')
          .doc(Auth.uid)
          .get();
      var workerdocumentSnapshot = await FirebaseFirestore.instance
          .collection('WORKERS')
          .doc(Auth.uid)
          .get();

      if (userdocumentSnapshot.exists) {
        return 1;
      } else if (workerdocumentSnapshot.exists) {
        return 2;
      } else {
        return 0;
      }
      }
    }

    // Future<int> checkFirstSeen() async {
    //   // SharedPreferences.setMockInitialValues({});
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   bool _seen = (prefs.getBool('seen') ?? false);
    //   if (_seen) {
    //     return 1;
    //   } else {
    //     await prefs.setBool('seen', true);
    //     return -1;
    //   }
    // }
  }


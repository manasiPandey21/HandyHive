import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:handyhive/Provider/users_provider.dart';
import 'package:handyhive/Screens/Common/splashScreen.dart';
import 'package:provider/provider.dart';
import 'Provider/auth.dart';
import 'Provider/workers_provider.dart';
import 'Screens/OnBoardingScreen/welcome_page.dart';
import 'Screens/User/user_bottom_nav.dart';
import 'Screens/Worker/worker_bottom_nav.dart';
import 'Screens/Authentication/login.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

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
        return UserBottomNavigation();
      // break;
      case 2:
        return WorkerBottomNavigation();
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

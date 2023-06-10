import 'package:flutter/material.dart';
import 'package:handyhive/Screens/User/chatpage_user.dart';
import 'package:handyhive/Screens/User/user_dashboard.dart';
import 'package:handyhive/Screens/User/user_edit_profile.dart';
import 'package:handyhive/Screens/Worker/chatpage_worker.dart';
import 'package:handyhive/Screens/Worker/worker_dashboard.dart';
import 'package:handyhive/Screens/Worker/worker_edit_profile.dart';
class WorkerBottomNavigation extends StatefulWidget {
  const WorkerBottomNavigation({super.key});

  @override
  State<WorkerBottomNavigation> createState() => _WorkerBottomNavigationState();
}

class _WorkerBottomNavigationState extends State<WorkerBottomNavigation> {
  int _currentIndex = 0;

  void _onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  TextEditingController search = TextEditingController();
  static List<Widget> _tabs = <Widget>[
    WorkerDashBoard(),
    ChatPageWorker(),
    WorkerEditProfile(),

    // Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: _tabs.elementAt(_currentIndex),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
           borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
        ],
        ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),),
                child: BottomNavigationBar(
                  // backgroundColor: CustomColors.secondaryColor,
                  selectedItemColor: Colors.pinkAccent,
                  unselectedItemColor: Colors.pink.shade50,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: "Home",
                      //backgroundColor: Colors.white
                      // title: Text('Home'),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.chat),
                      label: "Chat",
                     // backgroundColor: Colors.black
                      // title: Text('chat'),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.face_outlined),
                      label: "Me",
                     // backgroundColor: Colors.black
                      // title: Text('reviews'),
                    ),
                   
                  
                  ],
                   selectedIconTheme: IconThemeData(color: Colors.pinkAccent),
                    unselectedIconTheme: IconThemeData(color: Colors.grey),
                     currentIndex: _currentIndex,
                  onTap: _onTapped,
                ),
              ),
            ));
  }
}

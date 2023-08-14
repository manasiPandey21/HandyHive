import 'package:flutter/material.dart';
import 'package:handyhive/Screens/User/chatpage_user.dart';
import 'package:handyhive/Screens/User/user_dashboard.dart';
import 'package:handyhive/Screens/User/user_edit_profile.dart';
import 'package:handyhive/Screens/Worker/chatpage_worker.dart';
import 'package:handyhive/Screens/Worker/worker_dashboard.dart';
import 'package:handyhive/Screens/Worker/worker_edit_profile.dart';
import 'package:provider/provider.dart';

import '../../Models/workers.dart';
import '../../Provider/auth.dart';
import '../../Provider/workers_provider.dart';
import '../Common/load.dart';

class WorkerBottomNavigation extends StatefulWidget {
  const WorkerBottomNavigation({super.key});

  @override
  State<WorkerBottomNavigation> createState() => _WorkerBottomNavigationState();
}

class _WorkerBottomNavigationState extends State<WorkerBottomNavigation> {
  int _currentIndex = 0;
  bool _isInit = true;
  bool isLoading = true;
  static Worker? currWorker;

  void _onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isInit) {
      await Provider.of<WorkersProvider>(context, listen: false)
          .fetchAndSetWorkers()
          .then((value) async => await Provider.of<Auth>(context, listen: false)
                  .getFirebaseUser()
                  .then((value) async {
                setState(() {
                  var uid = Provider.of<Auth>(context, listen: false)
                      .firebaseUser!
                      .uid
                      .toString();
                  currWorker =
                      Provider.of<WorkersProvider>(context, listen: false)
                          .getWorkers(uid.toString());
                  _tabs = <Widget>[
                    WorkerDashBoard(currWorker),
                    ChatPageWorker(),
                    WorkerEditProfile(),
                  ];
                  isLoading = false;
                });
              }));
    }
    _isInit = false;
  }

  TextEditingController search = TextEditingController();
  static List<Widget>? _tabs;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return isLoading
        ? LoadScreen()
        : Scaffold(
            body: _tabs!.elementAt(_currentIndex),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black38, spreadRadius: 0, blurRadius: 10),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
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

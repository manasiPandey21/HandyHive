import 'package:flutter/material.dart';
import 'package:handyhive/Screens/User/chatpage_user.dart';
import 'package:handyhive/Screens/User/user_dashboard.dart';
import 'package:handyhive/Screens/User/user_edit_profile.dart';
class UserBottomNavigation extends StatefulWidget {
  const UserBottomNavigation({super.key});

  @override
  State<UserBottomNavigation> createState() => _UserBottomNavigationState();
}

class _UserBottomNavigationState extends State<UserBottomNavigation> {
  int _currentIndex = 0;

  void _onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  TextEditingController search = TextEditingController();
  static List<Widget> _tabs = <Widget>[
    UserDashBoard(),
    ChatPageUser(),
    UserEditProfile(),

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
                      backgroundColor: Colors.white
                      // title: Text('Home'),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.chat),
                      label: "Chat",
                      backgroundColor: Colors.black
                      // title: Text('chat'),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.face_outlined),
                      label: "Me",
                      backgroundColor: Colors.black
                      // title: Text('reviews'),
                    ),
                   
                  
                  ],
                  // type: BottomNavigationBarType.fixed,
                    selectedIconTheme: IconThemeData(color: Colors.pinkAccent),
                    unselectedIconTheme: IconThemeData(color: Colors.grey),
                     currentIndex: _currentIndex,
                  onTap: _onTapped,
                ),
              ),
            ));
  }
}

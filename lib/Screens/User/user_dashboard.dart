import 'package:flutter/material.dart';
import 'package:handyhive/Screens/User/chatpage_user.dart';
import 'package:handyhive/Screens/User/user_dashboard2.dart';
import 'package:handyhive/Screens/User/user_edit_profile.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../Models/users.dart';
import '../../Provider/auth.dart';
import '../../Provider/users_provider.dart';

class UserDashBoard extends StatefulWidget {
  Users? currUser;
  UserDashBoard(this.currUser);

  @override
  State<UserDashBoard> createState() => _UserDashBoardState();
}

class _UserDashBoardState extends State<UserDashBoard> {
  //final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    {
      final width = MediaQuery.of(context).size.width;
      final height = MediaQuery.of(context).size.height;
      return Center(
        child: Scaffold(
            body: SingleChildScrollView(
          child: Column(children: [
            // Container(
            //   padding: const EdgeInsets.all(10),
            //   child: TextField(
            //     controller: _searchController,
            //     decoration: InputDecoration(
            //       hintText: 'Search...',
            //       suffixIcon: IconButton(
            //         icon: Icon(Icons.clear),
            //         onPressed: () => _searchController.clear(),
            //       ),
            //       prefixIcon: IconButton(
            //         icon: Icon(Icons.search),
            //         onPressed: () {},
            //       ),
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(20.0),
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Row(
                children: [
                  Text(
                    "Hey ${widget.currUser!.nameUser}",
                    style: TextStyle(
                        fontSize: 60,
                        fontFamily: 'Pacifico',
                        fontWeight: FontWeight.w100),
                  ),
                  Lottie.network(
                      'https://assets8.lottiefiles.com/packages/lf20_d00u59ww.json'),
                ],
              ),
            ),
            SizedBox(
              height: 100,
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      IconButton(
                        icon: Image.asset('assets/cooking.jpg'),
                        iconSize: 80,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                UserDashBoard2("Cooking", widget.currUser),
                          ));
                        },
                      ),
                      Text(
                        "Cooking",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Image.asset('assets/gardening.jpg'),
                        iconSize: 80,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                UserDashBoard2("Gardening", widget.currUser),
                          ));
                        },
                      ),
                      Text(
                        "Gardening",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Image.asset('assets/brooming.jpg'),
                        iconSize: 80,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                UserDashBoard2("Brooming", widget.currUser),
                          ));
                        },
                      ),
                      Text(
                        "Brooming",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Image.asset('assets/washingClothes.jpg'),
                        iconSize: 80,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => UserDashBoard2(
                                "Clothes Cleaning", widget.currUser),
                          ));
                        },
                      ),
                      Text(
                        "Clothes Cleaning",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),

            SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      IconButton(
                        icon: Image.asset('assets/babySitter.jpg'),
                        iconSize: 80,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                UserDashBoard2("BabySitter", widget.currUser),
                          ));
                        },
                      ),
                      Text(
                        "BabySitter",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Image.asset('assets/moping.jpg'),
                        iconSize: 80,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                UserDashBoard2("Sweeping", widget.currUser),
                          ));
                        },
                      ),
                      Text(
                        "Sweeping",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Image.asset('assets/ironing.jpg'),
                        iconSize: 80,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                UserDashBoard2("Ironing", widget.currUser),
                          ));
                        },
                      ),
                      Text(
                        "Ironing",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Image.asset('assets/Massager.jpg'),
                        iconSize: 80,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                UserDashBoard2("Massager", widget.currUser),
                          ));
                        },
                      ),
                      Text(
                        "Massager",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      IconButton(
                        icon: Image.asset('assets/driver.jpg'),
                        iconSize: 80,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                UserDashBoard2("Driver", widget.currUser),
                          ));
                        },
                      ),
                      Text(
                        "Driver",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Image.asset('assets/nursing.png'),
                        iconSize: 80,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                UserDashBoard2("Nurse", widget.currUser),
                          ));
                        },
                      ),
                      Text(
                        "Nurse",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Image.asset('assets/utensilsCleaning.jpg'),
                        iconSize: 80,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => UserDashBoard2(
                                "Utensils Cleaning", widget.currUser),
                          ));
                        },
                      ),
                      Text(
                        "Utensils",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ]),
        )),
      );
    }
  }
}

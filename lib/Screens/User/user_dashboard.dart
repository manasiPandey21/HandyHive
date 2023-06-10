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
  const UserDashBoard({super.key});

  @override
  State<UserDashBoard> createState() => _UserDashBoardState();
}

class _UserDashBoardState extends State<UserDashBoard> {
  @override
  final TextEditingController _searchController = TextEditingController();
  int currentIndex = 0;
  Users? currUser;
  bool _isInit = true;
  bool isLoading = true;

  
  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isInit) {
      await Provider.of<UsersProvider>(context, listen: false)
          .fetchAndSetUsers()
          .then((value) async => await Provider.of<Auth>(context, listen: false)
                  .getFirebaseUser()
                  .then((value) async {
                setState(() {
                  var uid = Provider.of<Auth>(context, listen: false)
                      .firebaseUser!
                      .uid
                      .toString();
                   currUser = Provider.of<UsersProvider>(context, listen: false)
                      .getUser(uid.toString());
                  isLoading = false;
                });
              }));
      
    }
    _isInit = false;
  }

  Widget build(BuildContext context) {
    {
      return Center(
        child: isLoading? Center(child: CircularProgressIndicator()) :Scaffold(
            
            
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
                SizedBox(height: 100,),
            Padding(
              padding: const EdgeInsets.only(left:18.0),
              child: Row(
               
               children: [
               
               Text("Hey ${currUser?.nameUser}",style: TextStyle(fontSize: 60,fontFamily: 'Pacifico',fontWeight: FontWeight.w100),),
               Lottie.network(
                 'https://assets8.lottiefiles.com/packages/lf20_d00u59ww.json'
               ),
               ],),
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
                            iconSize: 60,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => UserDashBoard2("Cooking"),
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
                            iconSize: 70,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => UserDashBoard2("Gardening"),
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
                            iconSize: 70,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => UserDashBoard2("Brooming"),
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
                            icon: Image.asset('assets/utensilsCleaning.jpg'),
                            iconSize: 60,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    UserDashBoard2("Utensils Cleaning"),
                              ));
                            },
                          ),
                          Text(
                            "Utensils",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: Image.asset('assets/washingClothes.jpg'),
                            iconSize: 60,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    UserDashBoard2("Clothes Cleaning"),
                              ));
                            },
                          ),
                          Text(
                            "Clothes Cleaning",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: Image.asset('assets/moping.jpg'),
                            iconSize: 60,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => UserDashBoard2("Sweeping"),
                              ));
                            },
                          ),
                          Text(
                            "Sweeping",
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
                            icon: Image.asset('assets/ironing.jpg'),
                            iconSize: 70,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => UserDashBoard2("Ironing"),
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
                            iconSize: 70,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => UserDashBoard2("Massager"),
                              ));
                            },
                          ),
                          Text(
                            "Massager",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: Image.asset('assets/babySitter.jpg'),
                            iconSize: 70,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    UserDashBoard2("BabySitter"),
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
                            icon: Image.asset('assets/driver.jpg'),
                            iconSize: 70,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => UserDashBoard2("Driver"),
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
                            iconSize: 70,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => UserDashBoard2("Nurse"),
                              ));
                            },
                          ),
                          Text(
                            "Nurse",
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

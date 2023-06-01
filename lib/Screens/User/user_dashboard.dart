import 'package:flutter/material.dart';
import 'package:handyhive/Screens/User/chatpage_user.dart';
import 'package:handyhive/Screens/User/user_dashboard2.dart';
import 'package:handyhive/Screens/User/user_edit_profile.dart';

class UserDashBoard extends StatefulWidget {
  const UserDashBoard({super.key});

  @override
  State<UserDashBoard> createState() => _UserDashBoardState();
}

class _UserDashBoardState extends State<UserDashBoard> {
  @override
  final TextEditingController _searchController = TextEditingController();
  int currentIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
    if (index == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ChatPageUser()));
    }
    if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserEditProfile(),
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    {
      return Scaffold(
          appBar: AppBar(
            title: Center(child: Text("DashBoard")),
            backgroundColor: Colors.pinkAccent,
          ),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: onItemTapped,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: Colors.pinkAccent,
                  ),
                  label: "Dashboard",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.message,
                    color: Colors.pinkAccent,
                  ),
                  label: "chat",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.shopping_bag,
                    color: Colors.pinkAccent,
                  ),
                  label: "My Choices",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.face_outlined,
                    color: Colors.pinkAccent,
                  ),
                  label: "Me",
                ),
              ]),
          body: SingleChildScrollView(
            child: Column(children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () => _searchController.clear(),
                    ),
                    prefixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {},
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
          
              SizedBox(
                height: 50,
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
          ));
    }
  }
}

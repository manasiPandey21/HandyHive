import 'package:flutter/material.dart';
import 'package:handyhive/Screens/User/WorkDetails/cooking.dart';
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
            title: Text("DashBoard"),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("sort"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("filter"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pinkAccent),
                      )),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("rating"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pinkAccent),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("experience"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent),
                    ),
                  )
                ],
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
                          icon: Image.asset('assets/xxx.png'),
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
                          icon: Image.asset('assets/ironing.webp'),
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
                          icon: Image.asset('assets/xxx.png'),
                          iconSize: 70,
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
                          icon: Image.asset('assets/cleaning.png'),
                          iconSize: 60,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  UserDashBoard2("Utensils  Cleaning"),
                            ));
                          },
                        ),
                        Text(
                          "Utensils Cleaning",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: Image.asset('assets/yyy.png'),
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
                    Column(
                      children: [
                        IconButton(
                          icon: Image.asset('assets/garden.png'),
                          iconSize: 60,
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
                          icon: Image.asset('assets/ironing.webp'),
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
                          icon: Image.asset('assets/xxx.png'),
                          iconSize: 70,
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
                          icon: Image.asset('assets/ironing.webp'),
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
                          icon: Image.asset('assets/xxx.png'),
                          iconSize: 70,
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
                          icon: Image.asset('assets/cooking.webp'),
                          iconSize: 70,
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
                          icon: Image.asset('assets/xxx.png'),
                          iconSize: 70,
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
                  ],
                ),
              ),
            ]),
          ));
    }
  }
}

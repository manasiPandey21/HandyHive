import 'package:flutter/material.dart';
import 'package:handyhive/UsersSide/woekDetails/cooking.dart';

class dashboardUsers extends StatefulWidget {
  const dashboardUsers({super.key});

  @override
  State<dashboardUsers> createState() => _dashboardUsersState();
}

class _dashboardUsersState extends State<dashboardUsers> {
  @override
  final TextEditingController _searchController = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("DashBoard"),
          backgroundColor: Colors.pinkAccent,
        ),
        bottomNavigationBar: BottomNavigationBar(
            //  backgroundColor: Colors.pinkAccent,
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
              // Use a Material design search bar
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  // Add a clear button to the search bar
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () => _searchController.clear(),
                  ),
                  // Add a search icon or button to the search bar
                  prefixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      // Perform the search here
                    },
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
                            builder: (context) => const Cooking(),
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
                            builder: (context) => const Cooking(),
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
                        icon: Image.asset('assets/xxx.png'),
                        iconSize: 70,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Cooking(),
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
                            builder: (context) => const Cooking(),
                          ));
                        },
                      ),
                      Text(
                        "Cleaning",
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
                            builder: (context) => const Cooking(),
                          ));
                        },
                      ),
                      Text(
                        "farming",
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
                            builder: (context) => const Cooking(),
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
                            builder: (context) => const Cooking(),
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
                        icon: Image.asset('assets/xxx.png'),
                        iconSize: 70,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Cooking(),
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
                            builder: (context) => const Cooking(),
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
                        icon: Image.asset('assets/xxx.png'),
                        iconSize: 70,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Cooking(),
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
                            builder: (context) => const Cooking(),
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
                            builder: (context) => const Cooking(),
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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handyhive/Models/users.dart';
import 'package:handyhive/Models/workers.dart';
import 'package:handyhive/Screens/Common/chatpage.dart';
import 'package:provider/provider.dart';

import '../../Additional/users_items.dart';
import '../../Provider/auth.dart';
import '../../Provider/users_provider.dart';
import '../../Provider/workers_provider.dart';
import '../../Widgets/item_widget.dart';

class WorkerDashBoard extends StatefulWidget {
  const WorkerDashBoard({Key? key}) : super(key: key);

  @override
  State<WorkerDashBoard> createState() => _WorkerDashBoardState();
}

class _WorkerDashBoardState extends State<WorkerDashBoard> {
  Worker? currWorker;
  bool _isInit = true;
  bool isLoading = true;
  List<Users> users = [];

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isInit) {
      await Provider.of<WorkersProvider>(context, listen: false)
          .fetchAndSetWorkers()
          .then((value) async => await Provider.of<Auth>(context, listen: false)
              .getFirebaseUser()
              .then((value) async => await Provider.of<UsersProvider>(context,
                      listen: false)
                  .fetchAndSetUsers()
                  .then((value) => {
                        setState(() {
                          var uid = Provider.of<Auth>(context, listen: false)
                              .firebaseUser!
                              .uid
                              .toString();
                          currWorker = Provider.of<WorkersProvider>(context,
                                  listen: false)
                              .getWorkers(uid.toString());
                          for (var userId in currWorker!.requests.keys) {
                            print(userId);
                            print(
                              Provider.of<UsersProvider>(context, listen: false)
                                  .usersss,
                            );
                            Users user = Provider.of<UsersProvider>(context,
                                    listen: false)
                                .getUser(userId.toString());
                            if (user != null) {
                              users.add(user);
                            }
                          }
                          isLoading = false;
                        })
                      })));
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final workersProvider =
        Provider.of<WorkersProvider>(context, listen: false);
    final usersProvider = Provider.of<UsersProvider>(context, listen: false);
    const iconSize = 50;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        leading: PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Menu",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.filter,
                          color: Colors.pinkAccent,
                        ),
                        Text("Filter"),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(Icons.sort, color: Colors.pinkAccent),
                        Text("Sort"),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(Icons.edit, color: Colors.pinkAccent),
                        Text("Edit work choice"),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(Icons.feedback, color: Colors.pinkAccent),
                        Text("Feedback"),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(Icons.privacy_tip, color: Colors.pinkAccent),
                        Text("Privacy Policy"),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(Icons.book, color: Colors.pinkAccent),
                        Text("Terms & conditions"),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(Icons.help, color: Colors.pinkAccent),
                        Text("Help"),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ];
          },
        ),
        title: Center(child: Text("Dashboard")),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notification_add),
            onPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onDoubleTap: () {},
              child: Icon(
                Icons.shopping_bag,
                color: Colors.pinkAccent,
              ),
            ),
            label: "My Clients",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.face_outlined,
              color: Colors.pinkAccent,
            ),
            label: "Me",
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Card(
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(children: [
                Row(children: [
                  FutureBuilder(
                    future: Provider.of<UsersProvider>(context, listen: false)
                        .getImageUrl(user.uidUser.toString()),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.all(28.0),
                          child: CircleAvatar(
                            radius: 40,
                            child: Image.network(snapshot.data.toString()),
                            backgroundColor: Colors.transparent,
                          ),
                        );
                      } else {
                        return CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.brown,
                          foregroundColor: Colors.brown,
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name:${user.nameUser}'),
                        Text('Age:${user.ageUser}'),
                        Text(
                          'Address:${user.addressUser}',
                        ),
                        Text('Gender:${user.genderUser}')
                      ],
                    ),
                  ),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ChatPage(),
                          ),
                        );
                      },
                      child: Text("Accept"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("Reject"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}

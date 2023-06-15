import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:handyhive/Models/users.dart';
import 'package:handyhive/Models/workers.dart';
import 'package:handyhive/Screens/Common/chatpage.dart';
import 'package:handyhive/Screens/Common/load.dart';
import 'package:handyhive/Screens/Worker/chatpage_worker.dart';
import 'package:handyhive/Screens/Worker/worker_edit_profile.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Provider/auth.dart';
import '../../Provider/users_provider.dart';
import '../../Provider/workers_provider.dart';

class WorkerDashBoard extends StatefulWidget {
  Worker? currWorker;
  WorkerDashBoard(this.currWorker);

  @override
  State<WorkerDashBoard> createState() => _WorkerDashBoardState();
}

class _WorkerDashBoardState extends State<WorkerDashBoard> {
  bool _isInit = true;
  bool isLoading = true;
  List<Users> users = [];
  int currentIndex = 0;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isInit) {
      await Provider.of<UsersProvider>(context, listen: false)
          .fetchAndSetUsers()
          .then((value) => {
                setState(() {
                  for (var entry in widget.currWorker!.requests.entries) {
                    Users user =
                        Provider.of<UsersProvider>(context, listen: false)
                            .getUser(entry.key.toString());
                    if (user != null && entry.value == 'false') {
                      users.add(user);
                    }
                  }
                  isLoading = false;
                })
              });
    }
    _isInit = false;
  }

  void addWorkerIdToUser(String userId) async {
    final workerId = widget.currWorker!.uidWorkers;
    final userProvider = Provider.of<UsersProvider>(context, listen: false);
    final user = userProvider.getUser(userId);

    final updatedAcceptedRequests = {
      ...user.acceptedRequests,
      workerId ?? '': 'false',
    };

    final updatedUser =
        user.copyWith(acceptedRequests: updatedAcceptedRequests);
    userProvider.updateUsers(updatedUser);
  }

  Future<void> acceptRequest(String? userId) async {
    final workersProvider =
        Provider.of<WorkersProvider>(context, listen: false);

    final currWorkerId = widget.currWorker!.uidWorkers ?? '';
    await workersProvider.acceptRequest(currWorkerId, userId!);

    setState(() {
      users.removeWhere((user) => user.uidUser == userId);
    });
  }

  Future<void> deleteRequest(String userId) async {
    final workersProvider =
        Provider.of<WorkersProvider>(context, listen: false);

    final currWorkerId = widget.currWorker?.uidWorkers ?? '';
    await workersProvider.deleteRequest(currWorkerId, userId);

    setState(() {
      users.removeWhere((user) => user.uidUser == userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    const iconSize = 50;
    return Center(
      child: isLoading
          ? Center(child: LoadScreen())
          : Scaffold(
              // appBar: AppBar(
              //   backgroundColor: Colors.pinkAccent,
              //   leading: PopupMenuButton(
              //     itemBuilder: (BuildContext context) {
              //       return [
              //         PopupMenuItem(
              //           child: Column(
              //             children: [
              //               SizedBox(
              //                 height: 10,
              //               ),
              //               Text(
              //                 "Menu",
              //                 style:
              //                     TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              //               ),
              //               SizedBox(
              //                 height: 20,
              //               ),
              //               Row(
              //                 children: [
              //                   Icon(
              //                     Icons.filter,
              //                     color: Colors.pinkAccent,
              //                   ),
              //                   Text("Filter"),
              //                 ],
              //               ),
              //               SizedBox(
              //                 height: 20,
              //               ),
              //               Row(
              //                 children: [
              //                   Icon(Icons.sort, color: Colors.pinkAccent),
              //                   Text("Sort"),
              //                 ],
              //               ),
              //               SizedBox(
              //                 height: 20,
              //               ),
              //               Row(
              //                 children: [
              //                   Icon(Icons.edit, color: Colors.pinkAccent),
              //                   Text("Edit work choice"),
              //                 ],
              //               ),
              //               SizedBox(
              //                 height: 20,
              //               ),
              //               Row(
              //                 children: [
              //                   Icon(Icons.feedback, color: Colors.pinkAccent),
              //                   Text("Feedback"),
              //                 ],
              //               ),
              //               SizedBox(
              //                 height: 20,
              //               ),
              //               Row(
              //                 children: [
              //                   Icon(Icons.privacy_tip, color: Colors.pinkAccent),
              //                   Text("Privacy Policy"),
              //                 ],
              //               ),
              //               SizedBox(
              //                 height: 20,
              //               ),
              //               Row(
              //                 children: [
              //                   Icon(Icons.book, color: Colors.pinkAccent),
              //                   Text("Terms & conditions"),
              //                 ],
              //               ),
              //               SizedBox(
              //                 height: 20,
              //               ),
              //               Row(
              //                 children: [
              //                   Icon(Icons.help, color: Colors.pinkAccent),
              //                   Text("Help"),
              //                 ],
              //               ),
              //               SizedBox(
              //                 height: 40,
              //               ),
              //             ],
              //           ),
              //         ),
              //       ];
              //     },
              //   ),
              // title: Center(child: Text("Dashboard")),
              // actions: <Widget>[
              //   IconButton(
              //     icon: Icon(Icons.search),
              //     onPressed: () {},
              //   ),
              //   IconButton(
              //     icon: Icon(Icons.notification_add),
              //     onPressed: () {},
              //   ),
              // ],

              body: Column(children: [
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      "Hey ${widget.currWorker?.nameWorkers}",
                      style: TextStyle(
                          fontSize: 50,
                          fontFamily: 'Pacifico',
                          fontWeight: FontWeight.w100),
                    )),
                    Lottie.network(
                        'https://assets8.lottiefiles.com/packages/lf20_d00u59ww.json'),
                  ],
                ),
              ),
              Expanded(
                child: users.length == 0
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.network(
                              'https://assets4.lottiefiles.com/packages/lf20_mznpnepo.json'),
                          Text(
                            'Sorry, Currently no requests',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ListView.builder(
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            final user = users[index];
                            return Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Card(
                                color: Colors.pink.shade50,
                                shape: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Column(children: [
                                  Row(children: [
                                    FutureBuilder(
                                      future: Provider.of<UsersProvider>(
                                              context,
                                              listen: false)
                                          .getImageUrl(user.uidUser.toString()),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Padding(
                                            padding: const EdgeInsets.all(18.0),
                                            child: CircleAvatar(
                                              radius: 50,
                                              backgroundImage:
                                                  CachedNetworkImageProvider(
                                                snapshot.data.toString(),
                                              ),
                                              backgroundColor:
                                                  Colors.transparent,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                          acceptRequest(user.uidUser);
                                          addWorkerIdToUser(user.uidUser);
                                          var whatsappUrl =
                                              "whatsapp://send?phone=${user.mobileNumberUser}" +
                                                  "&text=${Uri.encodeComponent('Hi, I am ${widget.currWorker!.nameWorkers} from HandyHive. How can I help you?')}";

                                          launch(whatsappUrl);
                                        },
                                        child: Text("Accept"),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.pinkAccent),
                                      ),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          deleteRequest(user.uidUser);
                                        },
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
                      ),
              )
            ])),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:handyhive/Models/workers.dart';
import 'package:handyhive/Provider/workers_provider.dart';
import 'package:handyhive/Screens/User/user_dashboard.dart';
import 'package:handyhive/Screens/User/user_edit_profile.dart';
import 'package:handyhive/Screens/User/workers_details.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../Models/users.dart';
import '../../Provider/auth.dart';
import '../../Provider/users_provider.dart';

class ChatPageUser extends StatefulWidget {
  const ChatPageUser({super.key});

  @override
  State<ChatPageUser> createState() => _ChatPageUserState();
}

class _ChatPageUserState extends State<ChatPageUser> {
  Users? currUser;
  bool _isInit = true;
  bool isLoading = true;
  List<Worker> acceptedworkers = [];
  int currentIndex = 0;
  void onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
    if (index == 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => UserDashBoard()));
    }
     if (index == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ChatPageUser()));
    }
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserEditProfile(),
        ),
      );
    }
  }

  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isInit) {
      await Provider.of<UsersProvider>(context, listen: false)
          .fetchAndSetUsers()
          .then((value) async => await Provider.of<Auth>(context, listen: false)
              .getFirebaseUser()
              .then((value) async => await Provider.of<WorkersProvider>(context,
                      listen: false)
                  .fetchAndSetWorkers()
                  .then((value) => {
                        setState(() {
                          var uid = Provider.of<Auth>(context, listen: false)
                              .firebaseUser!
                              .uid
                              .toString();
                          currUser =
                              Provider.of<UsersProvider>(context, listen: false)
                                  .getUser(uid.toString());
                          for (var entry
                              in currUser!.acceptedRequests.entries) {
                            Worker worker = Provider.of<WorkersProvider>(
                                    context,
                                    listen: false)
                                .getWorkers(entry.key.toString());
                            if (worker != null && entry.value == 'true') {
                              acceptedworkers.add(worker);
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
    return isLoading ? CircularProgressIndicator() : Scaffold(
        appBar: AppBar(
          title: Center(child: Text("My Chat")),
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
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.message,
                  color: Colors.pinkAccent,
                ),
                label: "",
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(
              //     Icons.shopping_bag,
              //     color: Colors.pinkAccent,
              //   ),
              //   label: "My Choices",
              // ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.face_outlined,
                  color: Colors.pinkAccent,
                ),
                label: "",
              ),
            ]),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            :  Expanded(
                child:  acceptedworkers.length==0 ? 
                  
                  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Lottie.network(
                              'https://assets4.lottiefiles.com/packages/lf20_mznpnepo.json'),
                          Text(
                            'Sorry, No request you have accepted yet',
                            style: TextStyle(
                              fontSize: 20,
                             
                            ),
                          ),
                        ],
                      )
                 
                 : Padding(
                   padding: const EdgeInsets.all(20.0),
                   child: ListView.builder(
            
                itemCount: acceptedworkers.length,
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      child: Card(
                          shape: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Column(children: [
                            Row(children: [
                              FutureBuilder(
                                future: Provider.of<WorkersProvider>(context,
                                        listen: false)
                                    .getImageUrl(
                                        acceptedworkers[index].uidWorkers),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: CircleAvatar(
                                        radius: 40,
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                          snapshot.data.toString(),
                                        ),
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
                                    Text(
                                        'Name:${acceptedworkers[index].nameWorkers}'),
                                    Text(
                                        'Age:${acceptedworkers[index].ageworker}'),
                                    Text(
                                      'Address:${acceptedworkers[index].addressWorker}',
                                    ),
                                    Text(
                                        'Gender:${acceptedworkers[index].genderworker}')
                                  ],
                                ),
                              ),
                            ]),
                          ])),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => WorkerDetails(
                              workerId: acceptedworkers[index].uidWorkers),
                        ));
                      },
                    ),
                  );
                },
            ))));
  }
}

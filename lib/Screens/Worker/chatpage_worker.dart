import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:handyhive/Models/workers.dart';
import 'package:handyhive/Provider/workers_provider.dart';
import 'package:handyhive/Screens/User/workers_details.dart';
import 'package:handyhive/Screens/Worker/user_details.dart';
import 'package:handyhive/Screens/Worker/worker_dashboard.dart';
import 'package:handyhive/Screens/Worker/worker_edit_profile.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../Models/users.dart';
import '../../Provider/auth.dart';
import '../../Provider/users_provider.dart';

class ChatPageWorker extends StatefulWidget {
  Worker? currWorker;
  ChatPageWorker(this.currWorker);

  @override
  State<ChatPageWorker> createState() => _ChatPageWorkerState();
}

class _ChatPageWorkerState extends State<ChatPageWorker> {
  bool _isInit = true;
  bool isLoading = true;

  List<Users> acceptedusers = [];
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
                    if (user != null && entry.value == 'true') {
                      acceptedusers.add(user);
                    }
                  }
                  isLoading = false;
                })
              });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Center(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Scaffold(
                appBar: AppBar(
                  title: Center(child: Text("My Chat")),
                  backgroundColor: Colors.pinkAccent,
                ),
                body: acceptedusers.length == 0
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Center(
                              child: Lottie.network(
                                'https://assets3.lottiefiles.com/packages/lf20_6PnLAF.json',
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ListView.builder(
                          itemCount: acceptedusers.length,
                          itemBuilder: (ctx, index) {
                            return Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: GestureDetector(
                                child: Card(
                                    color: Colors.pink.shade50,
                                    elevation: 5,
                                    shape: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Column(children: [
                                      Row(children: [
                                        FutureBuilder(
                                          future: Provider.of<UsersProvider>(
                                                  context,
                                                  listen: false)
                                              .getImageUrl(
                                                  acceptedusers[index].uidUser),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(28.0),
                                                child: CircleAvatar(
                                                  radius: 40,
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
                                                radius: 40,
                                                backgroundColor: Colors.brown,
                                                foregroundColor: Colors.brown,
                                                // child: CircularProgressIndicator(),
                                              );
                                            }
                                          },
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  'Name:${acceptedusers[index].nameUser}'),
                                              Text(
                                                  'Age:${acceptedusers[index].ageUser}'),
                                              Text(
                                                'Address:${acceptedusers[index].addressUser}',
                                              ),
                                              Text(
                                                  'Gender:${acceptedusers[index].genderUser}')
                                            ],
                                          ),
                                        ),
                                      ]),
                                    ])),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        UserDetails(acceptedusers[index]),
                                  ));
                                },
                              ),
                            );
                          },
                        )),
              ));
  }
}

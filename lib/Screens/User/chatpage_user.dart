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
  Users? currUser;
  ChatPageUser(this.currUser);

  @override
  State<ChatPageUser> createState() => _ChatPageUserState();
}

class _ChatPageUserState extends State<ChatPageUser> {
  bool _isInit = true;
  bool isLoading = true;
  List<Worker> acceptedworkers = [];
  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isInit) {
      await Provider.of<WorkersProvider>(context, listen: false)
          .fetchAndSetWorkers()
          .then((value) => {
                setState(() {
                  for (var entry in widget.currUser!.acceptedRequests.entries) {
                    Worker worker =
                        Provider.of<WorkersProvider>(context, listen: false)
                            .getWorkers(entry.key.toString());
                    if (worker != null && entry.value == 'true') {
                      acceptedworkers.add(worker);
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
                  // leading: IconButton(
                  //   icon: Icon(Icons.arrow_back, color: Colors.white),
                  //   onPressed: () {
                  //     Navigator.of(context).pop();
                  //   },
                  // ),
                  title: Center(child: Text("My Chat")),
                  backgroundColor: Colors.pinkAccent,
                ),
                body: acceptedworkers.length == 0
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Center(
                              child: Lottie.network(
                                'https://assets3.lottiefiles.com/packages/lf20_6PnLAF.json',
                              ),
                            ),
                          ),
                          // Text(
                          //   'Sorry, your chat list is empty :(',
                          //   style: TextStyle(
                          //     fontSize: 20,
                          //   ),
                          // ),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Column(children: [
                                      Row(children: [
                                        FutureBuilder(
                                          future: Provider.of<WorkersProvider>(
                                                  context,
                                                  listen: false)
                                              .getImageUrl(
                                                  acceptedworkers[index]
                                                      .uidWorkers),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
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
                                                radius: 60,
                                                backgroundColor: Colors.brown,
                                                foregroundColor: Colors.brown,
                                                //child:
                                                //CircularProgressIndicator(),
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
                                        acceptedworkers[index],
                                        widget.currUser),
                                  ));
                                },
                              ),
                            );
                          },
                        ))));
  }
}

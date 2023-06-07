import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:handyhive/Provider/auth.dart';
import 'package:handyhive/Provider/workers_provider.dart';
import 'package:handyhive/Screens/Common/chatpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:handyhive/Screens/Common/msgToast.dart';
import 'package:provider/provider.dart';

import '../../Models/users.dart';
import '../../Models/workers.dart';
import '../../Provider/users_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class WorkerDetails extends StatefulWidget {
  final String workerId;

  const WorkerDetails({Key? key, required this.workerId}) : super(key: key);

  @override
  _ServiceProviderDetailsState createState() => _ServiceProviderDetailsState();
}

class _ServiceProviderDetailsState extends State<WorkerDetails> {
  Future<String>? _imageUrlFuture;
  bool _isInit = true;
  bool isLoading = true;
  Users? currUser;

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

  void addUserIdToServiceProvider() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final serviceProviderId = widget.workerId;
    final workersProvider =
        Provider.of<WorkersProvider>(context, listen: false);
    final worker = workersProvider.getWorkerById(serviceProviderId);

    final updatedRequests = {
      ...worker.requests,
      userId ?? '': 'false',
    };

    final updatedWorker = worker.copyWith(requests: updatedRequests);
    workersProvider.updateWorkers(updatedWorker);
  }

  void addWorkerIdToUser() async {
    final workerId = widget.workerId;
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final userProvider = Provider.of<UsersProvider>(context, listen: false);
    final user = userProvider.getUser(userId!);

    final updatedAcceptedRequests = {
      ...user.acceptedRequests,
      workerId ?? '': 'false',
    };

    final updatedUser =
        user.copyWith(acceptedRequests: updatedAcceptedRequests);
    userProvider.updateUsers(updatedUser);
  }

  @override
  Widget build(BuildContext context) {
    final workersProvider = Provider.of<WorkersProvider>(context);
    final worker = workersProvider.getWorkerById(widget.workerId);

    return isLoading
        ? Builder(builder: (context) {
            return CircularProgressIndicator();
          })
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.pinkAccent,
              title: Center(child: Text('Service Provider Details')),
            ),
            body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.transparent,
                            child: FutureBuilder(
                              future: Provider.of<WorkersProvider>(context,
                                      listen: false)
                                  .getImageUrl(widget.workerId.toString()),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return CircleAvatar(
                                    radius: 60,
                                    backgroundImage: CachedNetworkImageProvider(
                                      snapshot.data.toString(),
                                    ),
                                    backgroundColor: Colors.transparent,
                                  );
                                } else if (snapshot.hasError) {
                                  return Icon(Icons.error);
                                } else {
                                  return CircularProgressIndicator();
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Name',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '${worker.nameWorkers ?? ""}',
                              ),
                              Divider(thickness: 1),
                              Text(
                                'Age',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text('${worker.ageworker ?? ""}'),
                              Divider(thickness: 1),
                              Text(
                                'Address',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text('${worker.addressWorker ?? ""}'),
                              Divider(thickness: 1),
                              Text(
                                'WorkExperience',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text('${worker.workExperienceworker ?? ""}'),
                              Divider(thickness: 1),
                              Text(
                                'Gender',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text('${worker.genderworker ?? ""}'),
                              Divider(thickness: 1),
                              Text(
                                'Religion',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text(' ${worker.religionworker ?? ""}'),
                              Divider(thickness: 1),
                              Text(
                                'Language: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text('${worker.languageworker ?? ""}'),
                              Divider(thickness: 1),
                              Text(
                                'MonthlyIncome',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text('${worker.monthlyIncomeworker ?? ""}'),
                              Divider(thickness: 1),
                              SizedBox(height: 30),
                              Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.pinkAccent),
                                  onPressed: () async {
                                    setState(
                                      () {
                                        if (!currUser!.acceptedRequests
                                            .containsKey(widget.workerId)) {
                                          addUserIdToServiceProvider();
                                          addWorkerIdToUser();
                                          currUser!.acceptedRequests[
                                              widget.workerId] = 'false';
                                          msgToast("Request Sent successfully");
                                        } else if (currUser!.acceptedRequests[
                                                widget.workerId] ==
                                            "true") {
                                          launch(
                                              'https://wa.me/${worker.mobileNoworker}');
                                          msgToast(
                                              "you can talk to ${worker.nameWorkers}+on whatsapp");
                                        }
                                      },
                                    );
                                  },
                                  child: (!currUser!.acceptedRequests
                                          .containsKey(widget.workerId))
                                      ? Text("Request")
                                      : (currUser!.acceptedRequests[
                                                  widget.workerId] ==
                                              "true")
                                          ? Text("Tap to Chat")
                                          : Text("Request Sent"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ));
  }
}

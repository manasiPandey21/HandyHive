import 'package:flutter/material.dart';
import 'package:handyhive/Provider/auth.dart';
import 'package:handyhive/Provider/workers_provider.dart';
import 'package:handyhive/Screens/Common/chatpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../../Models/users.dart';
import '../../Models/workers.dart';
import '../../Provider/users_provider.dart';

class WorkerDetails extends StatefulWidget {
  final String workerId;

  const WorkerDetails({Key? key, required this.workerId}) : super(key: key);

  @override
  _ServiceProviderDetailsState createState() => _ServiceProviderDetailsState();
}

class _ServiceProviderDetailsState extends State<WorkerDetails> {
  late Future<String> _imageUrlFuture;
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
      final workersProvider =
          Provider.of<WorkersProvider>(context, listen: false);

      _imageUrlFuture = workersProvider.getImageUrl(widget.workerId);
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

  Future<String?> fetchUserId(String workerId) async {
    DocumentSnapshot workerSnapshot = await FirebaseFirestore.instance
        .collection('WORKERS')
        .doc(workerId)
        .get();
    if (workerSnapshot.exists) {
      Worker worker =
          Worker.fromMap(workerSnapshot.data() as Map<String, dynamic>);
      return worker.requests['userId'];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final workersProvider = Provider.of<WorkersProvider>(context);
    final worker = workersProvider.getWorkerById(widget.workerId);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pinkAccent,
          title: Center(child: Text('Service Provider Details')),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Card(
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(children: [
                Row(children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: CircleAvatar(
                        radius: 80,
                        child: FutureBuilder(
                          future: _imageUrlFuture,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Image.network(snapshot.data.toString());
                            } else if (snapshot.hasError) {
                              return Icon(Icons.error);
                            } else {
                              return CircularProgressIndicator();
                            }
                          },
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Name: ${worker.nameWorkers ?? ""}',
                        ),
                        Text('Age: ${worker.ageworker ?? ""}'),
                        Text('Address: ${worker.addressWorker ?? ""}'),
                        Text(
                            'WorkExperience:${worker.workExperienceworker ?? ""}'),
                        Text('Gender:${worker.genderworker ?? ""}'),
                        Text('Religion: ${worker.religionworker ?? ""}'),
                        Text('Language: ${worker.languageworker ?? ""}'),
                        Text(
                            'MonthlyIncome:${worker.monthlyIncomeworker ?? ""}'),
                        SizedBox(height: 60),
                      ],
                    ),
                  ),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent),
                      onPressed: () async {
                        if (!currUser!.acceptedRequests
                            .containsKey(widget.workerId)) {
                          addUserIdToServiceProvider();
                          addWorkerIdToUser();
                        } else if (currUser!.acceptedRequests[widget.workerId] ==
                            "true") {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ChatPage(),
                            ),
                          );
                        }
                      },
                      child: (!currUser!.acceptedRequests
                              .containsKey(widget.workerId))
                          ? Text("Request")
                          : (currUser!.acceptedRequests[widget.workerId] ==
                                  "true")
                              ? Text("Tap to Chat")
                              : Text("Request Sent"),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ]),
            ),
          ),
        ));
  }
}

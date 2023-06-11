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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WorkerDetails extends StatefulWidget {
  final Worker worker;
  final Users? currUser;

  const WorkerDetails(this.worker, this.currUser);

  @override
  _ServiceProviderDetailsState createState() => _ServiceProviderDetailsState();
}

class _ServiceProviderDetailsState extends State<WorkerDetails> {
  Future<String>? _imageUrlFuture;

  void addUserIdToServiceProvider() async {
    final userId = widget.currUser!.uidUser;

    final workersProvider =
        Provider.of<WorkersProvider>(context, listen: false);

    final updatedRequests = {
      ...widget.worker.requests,
      userId ?? '': 'false',
    };

    final updatedWorker = widget.worker.copyWith(requests: updatedRequests);
    workersProvider.updateWorkers(updatedWorker);
  }

  void addWorkerIdToUser() async {
    final userProvider = Provider.of<UsersProvider>(context, listen: false);
    final user = widget.currUser;

    final updatedAcceptedRequests = {
      ...user!.acceptedRequests,
      widget.worker.uidWorkers ?? '': 'false',
    };

    final updatedUser =
        user.copyWith(acceptedRequests: updatedAcceptedRequests);
    userProvider.updateUsers(updatedUser);
  }

  @override
  Widget build(BuildContext context) {
    final workersProvider = Provider.of<WorkersProvider>(context);

    return 
        Scaffold(
            body: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    " ${widget.worker?.nameWorkers} Details",
                    style: TextStyle(
                        fontSize: 60,
                        fontFamily: 'Pacifico',
                        fontWeight: FontWeight.w100),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      color: Colors.pink.shade50,
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
                                    .getImageUrl(
                                        widget.worker.uidWorkers.toString()),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return CircleAvatar(
                                      radius: 60,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
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
                          padding: const EdgeInsets.only(left: 18.0, right: 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '${widget.worker.nameWorkers ?? ""}',
                              ),
                              Divider(thickness: 1),
                              Text(
                                'Age',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text('${widget.worker.ageworker ?? ""}'),
                              Divider(thickness: 1),
                              Text(
                                'Address',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text('${widget.worker.addressWorker ?? ""}'),
                              Divider(thickness: 1),
                              Text(
                                'WorkExperience',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text(
                                  '${widget.worker.workExperienceworker ?? ""}'),
                              Divider(thickness: 1),
                              Text(
                                'Gender',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text('${widget.worker.genderworker ?? ""}'),
                              Divider(thickness: 1),
                              Text(
                                'Religion',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text(' ${widget.worker.religionworker ?? ""}'),
                              Divider(thickness: 1),
                              Text(
                                'Language: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text('${widget.worker.languageworker ?? ""}'),
                              Divider(thickness: 1),
                              Text(
                                'MonthlyIncome',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text(
                                  '${widget.worker.monthlyIncomeworker ?? ""}'),
                              Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.pinkAccent),
                                  onPressed: () async {
                                    setState(
                                      () {
                                        if (!widget.currUser!.acceptedRequests
                                            .containsKey(
                                                widget.worker.uidWorkers)) {
                                          addUserIdToServiceProvider();
                                          addWorkerIdToUser();
                                          widget.currUser!.acceptedRequests[widget
                                              .worker.uidWorkers] = 'false';
                                          msgToast(
                                              "Request Sent successfully");
                                        } else if (widget.currUser!.acceptedRequests[
                                                widget.worker.uidWorkers] ==
                                            "true") {
                                          launch(
                                              'https://wa.me/${widget.worker.mobileNoworker}');
                                          msgToast(
                                              "you can talk to ${widget.worker.nameWorkers}+on whatsapp");
                                        }
                                      },
                                    );
                                  },
                                  child: (!widget.currUser!.acceptedRequests
                                          .containsKey(
                                              widget.worker.uidWorkers))
                                      ? Text("Request")
                                      : (widget.currUser!.acceptedRequests[
                                                  widget.worker.uidWorkers] ==
                                              "true")
                                          ? Text("Tap to Chat")
                                          : Text("Request Sent"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                ])));
  }
}

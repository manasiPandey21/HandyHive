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
  _WorkerDetailsState createState() => _WorkerDetailsState();
}

class _WorkerDetailsState extends State<WorkerDetails> {
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final workersProvider = Provider.of<WorkersProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.pinkAccent),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
  child: Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: Center(
              child: Text(
                "${widget.worker.nameWorkers} Details",
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Pacifico',
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            color: Colors.pink.shade50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.transparent,
                    child: FutureBuilder(
                      future: Provider.of<WorkersProvider>(context, listen: false)
                          .getImageUrl(widget.worker.uidWorkers.toString()),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return CircleAvatar(
                            radius: 60,
                            backgroundImage: CachedNetworkImageProvider(
                              snapshot.data.toString(),
                            ),
                            backgroundColor: Colors.transparent,
                          );
                        } else {
                          return CircleAvatar(
                            radius: 90,
                            backgroundColor: Colors.brown,
                            foregroundColor: Colors.brown,
                            // child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0, right: 18),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Name',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Text('${widget.worker.nameWorkers ?? ""}'),
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
                                Text('${widget.worker.workExperienceworker ?? ""}'),
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
                                  'Language',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Text('${widget.worker.languageworker ?? ""}'),
                                Divider(thickness: 1),
                                Text(
                                  'Monthly Income',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Text('${widget.worker.monthlyIncomeworker ?? ""}'),
                                SizedBox(height: 20),
                                Center(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.pinkAccent,
                                    ),
                                    onPressed: () async {
                                      setState(() {
                                        if (!widget.currUser!.acceptedRequests.containsKey(widget.worker.uidWorkers)) {
                                          addUserIdToServiceProvider();
                                          addWorkerIdToUser();
                                          widget.currUser!.acceptedRequests[widget.worker.uidWorkers] = 'false';
                                          msgToast("Request Sent successfully");
                                        } else if (widget.currUser!.acceptedRequests[widget.worker.uidWorkers] == "true") {
                                          launch('https://wa.me/${widget.worker.mobileNoworker}');
                                          msgToast("You can talk to ${widget.worker.nameWorkers} on WhatsApp");
                                        }
                                      });
                                    },
                                    child: (!widget.currUser!.acceptedRequests.containsKey(widget.worker.uidWorkers))
                                        ? Text("Request")
                                        : (widget.currUser!.acceptedRequests[widget.worker.uidWorkers] == "true")
                                            ? Text("Tap to Chat")
                                            : Text("Request Sent"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

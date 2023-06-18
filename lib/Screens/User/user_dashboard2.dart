import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:handyhive/Provider/workers_provider.dart';
import 'package:handyhive/Screens/Common/load.dart';
import 'package:handyhive/Screens/Common/msgToast.dart';

import 'package:handyhive/Screens/User/workers_details.dart';
import 'package:handyhive/Screens/Worker/worker_edit_profile.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../Models/users.dart';
import '../../Provider/auth.dart';
import '../../Provider/users_provider.dart';

class UserDashBoard2 extends StatefulWidget {
  String selectedService;
  UserDashBoard2(this.selectedService);

  @override
  _UserDashBoard2State createState() => _UserDashBoard2State();
}

class _UserDashBoard2State extends State<UserDashBoard2> {
  bool _isInit = true;
  bool isLoading = true;
  static Users? currUser;
   @override
  void initState() {
    super.initState();
    final workersProvider =
        Provider.of<WorkersProvider>(context, listen: false);
    workersProvider.fetchAndSetWorkers();
  }
   @override
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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return isLoading ? LoadScreen() : Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.pinkAccent,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Consumer<WorkersProvider>(
        builder: (context, workersProvider, _) {
          final workers =
              workersProvider.getWorkersByService(widget.selectedService);

          return Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                " ${widget.selectedService}",
                style: TextStyle(
                    fontSize: 60,
                    fontFamily: 'Pacifico',
                    fontWeight: FontWeight.w100),
              ),
              SizedBox(height: 20),
              Expanded(
                child: workers.length == 0
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.network(
                              'https://assets4.lottiefiles.com/packages/lf20_mznpnepo.json'),
                          Text(
                            'Sorry, No workers found',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ListView.builder(
                          itemCount: workers.length,
                          itemBuilder: (context, index) {
                            final worker = workers[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Card(
                                shadowColor: Colors.grey,
                                elevation: 5,
                                color: Colors.pink.shade50,
                                borderOnForeground: true,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                //margin: EdgeInsets.only(right: 10),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 20, top: 20),
                                  child: ListTile(
                                    leading: FutureBuilder(
                                      future: Provider.of<WorkersProvider>(
                                              context,
                                              listen: false)
                                          .getImageUrl(
                                              worker.uidWorkers.toString()),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return CircleAvatar(
                                            radius: 90,
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                              snapshot.data.toString(),
                                            ),
                                            backgroundColor: Colors.transparent,
                                          );
                                        } else {
                                          return CircleAvatar(
                                            radius: 100,
                                            backgroundColor: Colors.brown,
                                            foregroundColor: Colors.brown,
                                            // child: CircularProgressIndicator(),
                                          );
                                        }
                                      },
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text.rich(
                                          TextSpan(
                                            text: 'Name:  ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: '${worker!.nameWorkers}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text.rich(
                                          TextSpan(
                                            text: 'Age:  ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: '${worker!.ageworker}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text.rich(
                                          TextSpan(
                                            text: 'Address:  ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            children: [
                                              TextSpan(
                                                text:
                                                    '${worker!.addressWorker}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => WorkerDetails(
                                              worker, currUser),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

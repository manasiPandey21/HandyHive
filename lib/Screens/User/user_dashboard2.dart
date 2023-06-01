import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:handyhive/Provider/workers_provider.dart';

import 'package:handyhive/Screens/User/workers_details.dart';
import 'package:handyhive/Screens/Worker/worker_edit_profile.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class UserDashBoard2 extends StatefulWidget {
  String selectedService;
  UserDashBoard2(this.selectedService);

  @override
  _UserDashBoard2State createState() => _UserDashBoard2State();
}

class _UserDashBoard2State extends State<UserDashBoard2> {
  @override
  void initState() {
    super.initState();
    final workersProvider =
        Provider.of<WorkersProvider>(context, listen: false);
    workersProvider.fetchAndSetWorkers();
  }
  

  @override
  Widget build(BuildContext context) {
    final serviceProviderProvider = Provider.of<WorkersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Center(child: Text('User Dashboard')),
      ),
      body: Consumer<WorkersProvider>(
        builder: (context, workersProvider, _) {
          final workers =
              workersProvider.getWorkersByService(widget.selectedService);

          return Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Text(
                'Selected Service: ${widget.selectedService}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: workers.length==0 ? Container(
                  child:
                      Lottie.network(
                      'https://assets4.lottiefiles.com/packages/lf20_mznpnepo.json'),
                       
                    
                  )
                 
                 : Padding(
                   padding: const EdgeInsets.all(18.0),
                   child: ListView.builder(
                    itemCount: workers.length,
                    itemBuilder: (context, index) {
                      final worker = workers[index];
                      return Card(
                        margin: EdgeInsets.only(left: 30, right: 30),
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: ListTile(
                            leading: FutureBuilder(
                              future: Provider.of<WorkersProvider>(context,
                                      listen: false)
                                  .getImageUrl(worker.uidWorkers.toString()),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return CircleAvatar(
                                    radius: 40,
                                    backgroundImage: CachedNetworkImageProvider(
                                    snapshot.data.toString(),
                                  ),
                                    backgroundColor: Colors.transparent,
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
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Name: ${worker.nameWorkers ?? ""}'),
                                Text('Age: ${worker.ageworker ?? ""}'),
                                Text('Address: ${worker.addressWorker ?? ""}'),
                              ],
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => WorkerDetails(
                                    workerId: worker.uidWorkers.toString(),
                                  ),
                                ),
                              );
                            },
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

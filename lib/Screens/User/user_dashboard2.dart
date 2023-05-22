import 'package:flutter/material.dart';
import 'package:handyhive/Provider/workers_provider.dart';
import 'package:handyhive/Screens/User/ServiceProvidersDetails.dart';
import 'package:handyhive/Screens/Worker/worker_edit_profile.dart';
import 'package:provider/provider.dart';

class UserDashBoard2 extends StatefulWidget {
  const UserDashBoard2({Key? key}) : super(key: key);

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
    // Retrieve the selected service
    final selectedService = 'cooking'; // Replace with your selected service

    final workersProvider = Provider.of<WorkersProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Center(child: Text('User Dashboard')),
      ),
      body: Consumer<WorkersProvider>(
        builder: (context, workersProvider, _) {
          // Retrieve the workers for the selected service
          final workers = workersProvider.getWorkersByService(selectedService);

          return Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Text(
                'Selected Service: $selectedService',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: workers.length,
                  itemBuilder: (context, index) {
                    final worker = workers[index];
                    return Card(
                      margin: EdgeInsets.only(left: 30, right: 30),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListTile(
                          leading: FutureBuilder(
                            future: Provider.of<WorkersProvider>(context,
                                    listen: false)
                                .getImageUrl(worker.uidWorkers.toString()),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return CircleAvatar(
                                  radius: 40,
                                  child: Image.network(snapshot.data.toString()),
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
                              Text('UserID: ${worker.uidWorkers ?? ""}'),
                            ],
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ServiceProviderDetails(
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
            ],
          );
        },
      ),
    );
  }
}
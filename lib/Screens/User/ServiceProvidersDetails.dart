import 'package:flutter/material.dart';
import 'package:handyhive/Provider/workers_provider.dart';
import 'package:handyhive/Screens/Common/chatpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class ServiceProviderDetails extends StatefulWidget {
  final String workerId;

  const ServiceProviderDetails({Key? key, required this.workerId})
      : super(key: key);

  @override
  _ServiceProviderDetailsState createState() => _ServiceProviderDetailsState();
}

class _ServiceProviderDetailsState extends State<ServiceProviderDetails> {
  late Future<String> _imageUrlFuture;

  @override
  void initState() {
    super.initState();
    final workersProvider =
        Provider.of<WorkersProvider>(context, listen: false);
    _imageUrlFuture = workersProvider.getImageUrl(widget.workerId);
  }
void addUserIdToServiceProvider() async {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  final serviceProviderId = widget.workerId;
  final workersProvider = Provider.of<WorkersProvider>(context, listen: false);
  final worker = workersProvider.getWorkerById(serviceProviderId);

  final updatedRequests = {
    ...worker.requests,
    userId ?? '': 'false',
  };

  final updatedWorker = worker.copyWith(requests: updatedRequests);
  workersProvider.updateWorkers(updatedWorker);

  final chatCollection = FirebaseFirestore.instance.collection('chats');
  final serviceProviderDoc = chatCollection.doc(serviceProviderId);

  serviceProviderDoc.update({
    'requests': updatedRequests,
  });
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
            child: Column(children: [
          SizedBox(
            height: 40,
          ),
          Center(
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
          SizedBox(
            height: 40,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name: ${worker.nameWorkers ?? ""}',
                style: TextStyle(fontSize: 20),
              ),
              Text('Age: ${worker.ageworker ?? ""}'),
              Text('Address: ${worker.addressWorker ?? ""}'),
              Text('WorkExperience:${worker.workExperienceworker ?? ""}'),
              Text('Gender:${worker.genderworker ?? ""}'),
              SizedBox(height: 60),
               Text('Requests:'),
    
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent),
                onPressed: () {

                  addUserIdToServiceProvider();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ChatPage(),
                    ),
                  );
                },
                child: Text("Click To Chat"),
              ),
            ],
          )
        ])));
  }
}

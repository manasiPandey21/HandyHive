import 'package:flutter/material.dart';
import 'package:handyhive/Provider/workers_provider.dart';
import 'package:handyhive/Screens/Common/chatpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class WorkerDetails extends StatefulWidget {
  final String workerId;

  const WorkerDetails({Key? key, required this.workerId})
      : super(key: key);

  @override
  _ServiceProviderDetailsState createState() => _ServiceProviderDetailsState();
}

class _ServiceProviderDetailsState extends State<WorkerDetails> {
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
                      SizedBox(height: 30,),
                    Text('Name: ${worker.nameWorkers ?? ""}',),
                Text('Age: ${worker.ageworker ?? ""}'),
                Text('Address: ${worker.addressWorker ?? ""}'),
                Text('WorkExperience:${worker.workExperienceworker ?? ""}'),
                Text('Gender:${worker.genderworker ?? ""}'),
                Text('Religion: ${worker.religionworker ?? ""}'),
                Text('Language: ${worker.languageworker ?? ""}'),
                Text('MonthlyIncome:${worker.monthlyIncomeworker ?? ""}'),
                
                SizedBox(height: 60),
                     ], 
                    ),
                  ),]),
                
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    
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
                ),],),
                   SizedBox(height: 20,),
                 
                ]),),
            ),
        ));
  }
}

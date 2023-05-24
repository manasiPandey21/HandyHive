
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:handyhive/Models/users.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../Models/workers.dart';

class WorkersProvider with ChangeNotifier {
  List<Worker> serviceP = [];

  

get workers => null;  Worker getWorkerById(String workerId) {
    return serviceP.firstWhere((worker) => worker.uidWorkers == workerId);
  }

  Worker getWorkers(String index) {
    return serviceP.firstWhere((e) => e.uidWorkers == index);
  }

  Future<void> fetchAndSetWorkers() async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('WORKERS');
    QuerySnapshot allDataQuerySnapshot = await collectionRef.get();
  serviceP = List<Worker>.from(allDataQuerySnapshot.docs
    .map((doc) => doc.data() as Map<String, dynamic>)
    .map((e) => Worker.fromMap(e))
    .toList());

    notifyListeners();
  }

  Future<void> updateWorkers(Worker t) async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('WORKERS');
    await collectionRef.doc(t.uidWorkers).update(t.toMap()).then((_) {});
    await fetchAndSetWorkers();
    notifyListeners();
  }

  Future<void> addWorkers(Worker t) async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('WORKERS');
    String uid = t.uidWorkers;
    await collectionRef.doc(uid).set(t.toMap());
    await fetchAndSetWorkers();
    notifyListeners();
    return;
  }
   Future<void> deleteRequest(String workerId, String userId) async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('WORKERS');
   
    await collectionRef.doc(workerId).update({
      'requests.$userId': FieldValue.delete(),
    });

    await fetchAndSetWorkers();
    notifyListeners();
  }
  Future<void> acceptRequest(String workerId, String userId) async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('WORKERS');

    
    await collectionRef.doc(workerId).update({
      'requests.$userId': "true",
    });
    await fetchAndSetWorkers();
    notifyListeners();
  }





  List<Worker> getWorkersByService(String service) {
    fetchAndSetWorkers();
    return serviceP
        .where((worker) => worker.service.any((s) => s.name == service))
        .toList();
  }


  Future<String> getImageUrl(String id) async {
    String imageUrl = await firebase_storage.FirebaseStorage.instance
        .ref('service_providerImages/$id')
        .getDownloadURL();
    return imageUrl;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:handyhive/Models/users.dart';

import '../Models/workers.dart';

class WorkersProvider with ChangeNotifier {
  List<Worker> serviceP = [];

  Worker getWorkers(String index) {
    return serviceP.firstWhere((e) => e.uidWorkers == index);
  }

  Future<void> fetchAndSetWorkers() async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('WORKERS');
    QuerySnapshot allDataQuerySnapshot = await _collectionRef.get();
    serviceP = allDataQuerySnapshot.docs
        .map((doc) => doc.data())
        .toList()
        .map((e) => Worker.fromMap(e as Map<String, dynamic>))
        .toList()
        .cast<Worker>();
    notifyListeners();
  }

  Future<void> updateWorkers(Worker t) async {
    CollectionReference serviceP =
        FirebaseFirestore.instance.collection('WORKERS');
    await serviceP.doc(t.uidWorkers).update(t.toMap()).then((_) {});
    await fetchAndSetWorkers();
    notifyListeners();
  }

  Future<void> addWorkers(Worker t) async {
    CollectionReference serviceP =
        FirebaseFirestore.instance.collection('WORKERS');
    String uid = t.uidWorkers;
    await serviceP.doc(uid).set(t.toMap());
    await fetchAndSetWorkers();
    notifyListeners();
    return;
  }
}

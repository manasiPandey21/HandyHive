import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:handyhive/Models/workers.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../Models/users.dart';

class UsersProvider with ChangeNotifier {
  List<Users> usersss = [];

  Users getUser(String uid) {
    return usersss.firstWhere((e) => e.uidUser == uid);
  }

  Future<void> fetchAndSetUsers() async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('USERS');
    QuerySnapshot allDataQuerySnapshot = await _collectionRef.get();
    usersss = allDataQuerySnapshot.docs
        .map((doc) => doc.data())
        .toList()
        .map((e) => Users.fromMap(e as Map<String, dynamic>))
        .toList()
        .cast<Users>();
    notifyListeners();
  }

  Future<void> updateUsers(Users t) async {
    CollectionReference usersss =
        FirebaseFirestore.instance.collection('USERS');
    await usersss.doc(t.uidUser).update(t.toMap()).then((_) {});
    await fetchAndSetUsers();
    notifyListeners();
  }

  Future<void> addUsers(Users t) async {
    CollectionReference usersss =
        FirebaseFirestore.instance.collection('USERS');
    String uid = t.uidUser;
    await usersss.doc(uid).set(t.toMap());
    await fetchAndSetUsers();
    notifyListeners();
    return;
  }

  Future<String> getImageUrl(String id) async {
    String imageUrl = await firebase_storage.FirebaseStorage.instance
        .ref('UserImages/$id')
        .getDownloadURL();
    return imageUrl;
  }
}

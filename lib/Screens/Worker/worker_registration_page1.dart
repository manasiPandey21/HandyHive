import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart%20';
import 'package:flutter/material.dart';
import 'package:handyhive/Models/workers.dart';
import 'package:handyhive/Screens/Worker/worker_edit_profile.dart';
import 'package:handyhive/Screens/Worker/worker_registration_page2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../Provider/auth.dart';
import '../../Provider/workers_provider.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
class WorkerRegistrationPage1 extends StatefulWidget {
  const WorkerRegistrationPage1({super.key});

  @override
  State<WorkerRegistrationPage1> createState() =>
      _WorkerRegistrationPage1State();
}

class _WorkerRegistrationPage1State extends State<WorkerRegistrationPage1> {
  
  final picker = ImagePicker();
   String? uid;

  var _image;
  var imageUrl;
  var imagePicker;
  final _firebaseStorage = FirebaseStorage.instance;
  TextEditingController name = new TextEditingController();
  TextEditingController age = new TextEditingController();
  TextEditingController gender = new TextEditingController();
  TextEditingController mobileNo = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController maritalStatus = new TextEditingController();
  TextEditingController religion = new TextEditingController();
  TextEditingController monthlyIncome = new TextEditingController();
  TextEditingController workExperience = new TextEditingController();
  TextEditingController language = new TextEditingController();
  //Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  //Image Picker function to get image from camera
  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Profile")),
          backgroundColor: Colors.pinkAccent,
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            ProfileImage(),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 60,
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: name,
                decoration: InputDecoration(
                  labelText: "NAME",

                  //   hintText: "Manasi",
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              height: 60,
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: age,
                decoration: InputDecoration(
                  labelText: "AGE",

                  //   hintText: "19",
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              height: 60,
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: gender,
                decoration: InputDecoration(
                  labelText: "GENDER",
                  //   hintText: "Balajee colony",
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              height: 60,
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: mobileNo,
                decoration: InputDecoration(
                  labelText: "MOBILE NO.",
                  // hintText: "9555181663",
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              height: 60,
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: address,
                decoration: InputDecoration(
                  labelText: "ADDRESS",
                  //  hintText: "Manasi",
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              height: 60,
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: maritalStatus,
                decoration: InputDecoration(
                  labelText: "MARITAL STATUS",
                  // hintText: "unmarried",
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              height: 60,
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: religion,
                decoration: InputDecoration(
                  labelText: "RELIGION",
                  // hintText: "Hindu",
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              height: 60,
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: monthlyIncome,
                decoration: InputDecoration(
                  labelText: "MONTHLY INCOME",
                  // hintText: "Manasi",
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              height: 60,
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: workExperience,
                decoration: InputDecoration(
                  labelText: "WORK EXPERIENCE",
                  // hintText: "Manasi",
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              height: 60,
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: language,
                decoration: InputDecoration(
                  labelText: "LANGUAGE",
                  // hintText: "Manasi",
                  border: InputBorder.none,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await Provider.of<Auth>(context, listen: false)
                    .getFirebaseUser();
                String uid = Provider.of<Auth>(context, listen: false)
                    .firebaseUser!
                    .uid
                    .toString();
                Map <String,String> request= Map<String,String>();
                Provider.of<WorkersProvider>(context, listen: false).addWorkers(
                  Worker(
                    uidWorkers: uid.toString(),
                    nameWorkers: name.text,
                    ageworker: age.text,
                    genderworker: gender.text,
                    mobileNoworker: mobileNo.text,
                    maritalStatusworker: maritalStatus.text,
                    religionworker: religion.text,
                    monthlyIncomeworker: monthlyIncome.text,
                    workExperienceworker: workExperience.text,
                    addressWorker: address.text,
                    languageworker: language.text,
                    service: [],
                     requests:request,
                  ),
                );
                uid = Provider.of<Auth>(context, listen: false)
                    .firebaseUser!
                    .uid
                    .toString();
                if (_image != null) {
                  var snapshot = await _firebaseStorage
                      .ref()
                      .child('service_providerImages/$uid')
                      .putFile(_image);
                  var downloadUrl = await snapshot.ref.getDownloadURL();
                  if (mounted) {
                    setState(() {
                      imageUrl = downloadUrl;
                    });
                  }
                }

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const WorkerRegistrationPage2(),
                  ),
                );
              },
              child: Text("Submit"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40))),
            )
          ],
        )),
      ),
    );
  }

  Widget ProfileImage() {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 80,
            backgroundImage: _image != null
                ? FileImage(File(_image!.path))
                : AssetImage("assets/mansi.jpeg") as ImageProvider,
          ),
          Positioned(
            bottom: 20,
            right: 40,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context, builder: ((builder) => BottomSheet()));
              },
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget BottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(children: [
        Text(
          "Choose Profile Photo",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent),
                onPressed: () {
                  getImageFromCamera();
                },
                icon: Icon(Icons.camera_alt),
                label: Text("Camera")),
            SizedBox(
              width: 70,
            ),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent),
                onPressed: () {
                  getImageFromGallery();
                },
                icon: Icon(Icons.image),
                label: Text("Gallary")),
          ],
        )
      ]),
    );
  }
}

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:handyhive/Models/workers.dart';
import 'package:handyhive/Screens/Common/load.dart';
import 'package:handyhive/Screens/Worker/worker_dashboard.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../Provider/auth.dart';
import '../../Provider/workers_provider.dart';
import '../Authentication/login.dart';
import 'chatpage_worker.dart';

class WorkerEditProfile extends StatefulWidget {
 
  WorkerEditProfile();

  @override
  State<WorkerEditProfile> createState() => _WorkerEditProfileState();
}

class _WorkerEditProfileState extends State<WorkerEditProfile> {
  Worker? newWorker;
  bool _isInit = true;
  bool isLoading = true;
  final picker = ImagePicker();
  static Worker? currWorker;


  var _image;
  var imageUrl;
  var imagePicker;
  final _firebaseStorage = FirebaseStorage.instance;
  List<String> genderOptions = ['Men', 'Women', 'Others'];
  String selectedGender = 'Men';
  List<String> MarriageOptions = ['Married', 'Unmarried', 'Prefer Not to tell'];
  String selectedOption = 'Married';

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

  @override
  void initState() {
   
    super.initState();
  }
  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isInit) {
      await Provider.of<WorkersProvider>(context, listen: false)
          .fetchAndSetWorkers()
          .then((value) async => await Provider.of<Auth>(context, listen: false)
                  .getFirebaseUser()
                  .then((value) async {
                setState(() {
                  var uid = Provider.of<Auth>(context, listen: false)
                      .firebaseUser!
                      .uid
                      .toString();
                  currWorker =
                      Provider.of<WorkersProvider>(context, listen: false)
                          .getWorkers(uid.toString());
                  
                  isLoading = false;
                });
              }));
               name.text = currWorker!.nameWorkers;
    age.text = currWorker!.ageworker;
    gender.text = currWorker!.genderworker;
    mobileNo.text = currWorker!.mobileNoworker;
    address.text = currWorker!.addressWorker;
    maritalStatus.text = currWorker!.maritalStatusworker;
    workExperience.text = currWorker!.workExperienceworker;
    language.text = currWorker!.languageworker;
    }
    _isInit = false;
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);

      var uid = currWorker!.uidWorkers;

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
  }

  //Image Picker function to get image from camera
  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
    var uid = currWorker!.uidWorkers;
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
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return isLoading ? LoadScreen() :  Scaffold(
            appBar: AppBar(
              title: Center(child: Text("My Profile")),
              backgroundColor: Colors.pinkAccent,
            ),
            body: Padding(
                padding: EdgeInsets.all(20.0),
                child: Container(
                  child: ListView(
                    children: [
                      Center(
                        child: GestureDetector(
                            child: FutureBuilder(
                              future: Provider.of<WorkersProvider>(context,
                                      listen: false)
                                  .getImageUrl(
                                      currWorker!.uidWorkers.toString()),
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
                                    radius: 60,
                                    backgroundColor: Colors.brown,
                                    foregroundColor: Colors.brown,
                                    // child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                            onTap: () => {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: ((builder) => BottomSheet()))
                                }),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                          leading: Icon(
                            Icons.man_2_rounded,
                            color: Colors.pinkAccent,
                          ),
                          title: Text.rich(
                            TextSpan(
                              text: 'Name:  ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: '${currWorker!.nameWorkers}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          trailing: Icon(
                            Icons.edit,
                            color: Colors.pinkAccent,
                          ),
                          onTap: () {
                            setState(() {
                              showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30.0),
                                      topRight: Radius.circular(30.0),
                                    ),
                                  ),
                                  builder: (context) {
                                    return Padding(
                                      padding:
                                          MediaQuery.of(context).viewInsets,
                                      child: Wrap(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              controller: name,
                                              decoration: InputDecoration(
                                                  hintText: "Name",
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20))),
                                              keyboardType: TextInputType.name,
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              newWorker =
                                                  currWorker!.copyWith(
                                                nameWorkers:
                                                    name.text.toString(),
                                              );
                                              await Provider.of<
                                                          WorkersProvider>(
                                                      context,
                                                      listen: false)
                                                  .updateWorkers(newWorker!);
                                              setState(() {
                                                currWorker = newWorker;
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Text("UPDATE"),
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.pinkAccent),
                                          ),
                                        )
                                      ]),
                                    );
                                  });
                            });
                          }),
                      ListTile(
                          leading: Icon(
                            Icons.home,
                            color: Colors.pinkAccent,
                          ),
                          title: Text.rich(
                            TextSpan(
                              text: 'Address: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: '${currWorker!.addressWorker}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          trailing: Icon(
                            Icons.edit,
                            color: Colors.pinkAccent,
                          ),
                          onTap: () {
                            setState(() {
                              showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30.0),
                                      topRight: Radius.circular(30.0),
                                    ),
                                  ),
                                  builder: (context) {
                                    return Padding(
                                      padding:
                                          MediaQuery.of(context).viewInsets,
                                      child: Wrap(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              controller: address,
                                              decoration: InputDecoration(
                                                  hintText: "Address",
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20))),
                                              keyboardType:
                                                  TextInputType.streetAddress,
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              await Provider.of<Auth>(context,
                                                      listen: false)
                                                  .getFirebaseUser();
                                              var uid = Provider.of<Auth>(
                                                      context,
                                                      listen: false)
                                                  .firebaseUser!
                                                  .uid
                                                  .toString();
                                              newWorker = currWorker!
                                                  .copyWith(
                                                      addressWorker: address
                                                          .text
                                                          .toString());

                                              await Provider.of<
                                                          WorkersProvider>(
                                                      context,
                                                      listen: false)
                                                  .updateWorkers(newWorker!);
                                              setState(() {
                                                currWorker = newWorker;
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Text("UPDATE"),
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.pinkAccent),
                                          ),
                                        )
                                      ]),
                                    );
                                  });
                            });
                          }),
                      ListTile(
                          leading: Icon(
                            Icons.cake,
                            color: Colors.pinkAccent,
                          ),
                          title: Text.rich(
                            TextSpan(
                              text: 'Age: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: '${currWorker!.ageworker}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          trailing: Icon(
                            Icons.edit,
                            color: Colors.pinkAccent,
                          ),
                          onTap: () {
                            setState(() {
                              showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30.0),
                                      topRight: Radius.circular(30.0),
                                    ),
                                  ),
                                  builder: (context) {
                                    return Padding(
                                      padding:
                                          MediaQuery.of(context).viewInsets,
                                      child: Wrap(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              controller: age,
                                              decoration: InputDecoration(
                                                  hintText: "Age",
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20))),
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              newWorker = currWorker!
                                                  .copyWith(
                                                      ageworker:
                                                          age.text.toString());
                                              await Provider.of<
                                                          WorkersProvider>(
                                                      context,
                                                      listen: false)
                                                  .updateWorkers(newWorker!);
                                              setState(() {
                                                currWorker = newWorker;
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Text("UPDATE"),
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.pinkAccent),
                                          ),
                                        )
                                      ]),
                                    );
                                  });
                            });
                          }),
                      ListTile(
                        leading: Icon(
                          Icons.man_2_rounded,
                          color: Colors.pinkAccent,
                        ),
                        title: Text.rich(
                          TextSpan(
                            text: 'Gender:  ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: '${currWorker!.genderworker}',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        trailing: Icon(
                          Icons.edit,
                          color: Colors.pinkAccent,
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Select Gender'),
                                content: DropdownButtonFormField<String>(
                                  value: selectedGender,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedGender = newValue!;
                                    });
                                  },
                                  items: genderOptions
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                                actions: <Widget>[
                                  ElevatedButton(
                                    onPressed: () async {
                                      newWorker = currWorker!.copyWith(
                                        genderworker: selectedGender,
                                      );

                                      await Provider.of<WorkersProvider>(
                                              context,
                                              listen: false)
                                          .updateWorkers(newWorker!);
                                      setState(() {
                                        currWorker = newWorker;
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Text("UPDATE"),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.pinkAccent),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      ListTile(
                          leading: Icon(
                            Icons.call,
                            color: Colors.pinkAccent,
                          ),
                          title: Text.rich(
                            TextSpan(
                              text: 'Mobile No: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: '${currWorker!.mobileNoworker}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {}),
                      ListTile(
                        leading: Icon(
                          Icons.family_restroom,
                          color: Colors.pinkAccent,
                        ),
                        title: Text.rich(
                          TextSpan(
                            text: 'Marital Status: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    '${currWorker!.maritalStatusworker}',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        trailing: Icon(
                          Icons.edit,
                          color: Colors.pinkAccent,
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Marital Status'),
                                content: DropdownButtonFormField<String>(
                                  value: selectedOption,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedOption = newValue!;
                                    });
                                  },
                                  items: MarriageOptions.map<
                                      DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                                actions: <Widget>[
                                  ElevatedButton(
                                    onPressed: () async {
                                      newWorker = currWorker!.copyWith(
                                        maritalStatusworker: selectedOption,
                                      );

                                      await Provider.of<WorkersProvider>(
                                              context,
                                              listen: false)
                                          .updateWorkers(newWorker!);
                                      setState(() {
                                        currWorker = newWorker;
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Text("UPDATE"),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.pinkAccent),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      ListTile(
                          leading: Icon(
                            Icons.work_history,
                            color: Colors.pinkAccent,
                          ),
                          title: Text.rich(
                            TextSpan(
                              text: 'Work experience: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      '${currWorker!.workExperienceworker}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          trailing: Icon(
                            Icons.edit,
                            color: Colors.pinkAccent,
                          ),
                          onTap: () {
                            setState(() {
                              showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30.0),
                                      topRight: Radius.circular(30.0),
                                    ),
                                  ),
                                  builder: (context) {
                                    return Padding(
                                      padding:
                                          MediaQuery.of(context).viewInsets,
                                      child: Wrap(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              controller: workExperience,
                                              decoration: InputDecoration(
                                                  hintText: "Work Experience",
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20))),
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              await Provider.of<Auth>(context,
                                                      listen: false)
                                                  .getFirebaseUser();
                                              var uid = Provider.of<Auth>(
                                                      context,
                                                      listen: false)
                                                  .firebaseUser!
                                                  .uid
                                                  .toString();
                                              newWorker = currWorker!
                                                  .copyWith(
                                                      workExperienceworker:
                                                          workExperience.text
                                                              .toString());

                                              await Provider.of<
                                                          WorkersProvider>(
                                                      context,
                                                      listen: false)
                                                  .updateWorkers(newWorker!);
                                              setState(() {
                                                currWorker = newWorker;
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Text("UPDATE"),
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.pinkAccent),
                                          ),
                                        )
                                      ]),
                                    );
                                  });
                            });
                          }),
                      ListTile(
                          leading: Icon(
                            Icons.language,
                            color: Colors.pinkAccent,
                          ),
                          title: Text.rich(
                            TextSpan(
                              text: 'Language: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: '${currWorker!.languageworker}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          trailing: Icon(
                            Icons.edit,
                            color: Colors.pinkAccent,
                          ),
                          onTap: () {
                            setState(() {
                              showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30.0),
                                      topRight: Radius.circular(30.0),
                                    ),
                                  ),
                                  builder: (context) {
                                    return Padding(
                                      padding:
                                          MediaQuery.of(context).viewInsets,
                                      child: Wrap(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              controller: language,
                                              decoration: InputDecoration(
                                                  hintText: "Language",
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20))),
                                              keyboardType: TextInputType.name,
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              await Provider.of<Auth>(context,
                                                      listen: false)
                                                  .getFirebaseUser();
                                              var uid = Provider.of<Auth>(
                                                      context,
                                                      listen: false)
                                                  .firebaseUser!
                                                  .uid
                                                  .toString();
                                              newWorker = currWorker!
                                                  .copyWith(
                                                      languageworker: language
                                                          .text
                                                          .toString());

                                              await Provider.of<
                                                          WorkersProvider>(
                                                      context,
                                                      listen: false)
                                                  .updateWorkers(newWorker!);
                                              setState(() {
                                                currWorker = newWorker;
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Text("UPDATE"),
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.pinkAccent),
                                          ),
                                        )
                                      ]),
                                    );
                                  });
                            });
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 140, right: 140),
                        child: ElevatedButton(
                          onPressed: () {
                            showLogoutConfirmationDialog(context);
                          },
                          child: Text("Log Out"),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pinkAccent),
                        ),
                      )
                    ],
                  ),
                )));
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
                onPressed: () async {
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
                onPressed: () async {
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

void showLogoutConfirmationDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout Confirmation'),
          content: Text('Are you sure you want to log out?'),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink.shade100,
                  elevation: 10,
                  shadowColor: Colors.grey),
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  elevation: 10,
                  shadowColor: Colors.grey.shade100),
              child: Text('Yes'),
              onPressed: () async {
                await Provider.of<Auth>(context, listen: false).logout();

                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) {
                  return Login();
                }), (route) => false);
              },
            ),
          ],
        );
      });
}

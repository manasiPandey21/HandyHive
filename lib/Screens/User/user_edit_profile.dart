import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handyhive/Models/users.dart';
import 'package:handyhive/Provider/users_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import '../../Provider/auth.dart';
import 'package:handyhive/Screens/User/user_registration_page1.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserEditProfile extends StatefulWidget {
  const UserEditProfile({Key? key}) : super(key: key);

  @override
  State<UserEditProfile> createState() => _UserEditProfileState();
}

class _UserEditProfileState extends State<UserEditProfile> {
  @override
  final picker = ImagePicker();
  Users? currUser;
  Users? newUser;
  bool _isInit = true;
  bool isLoading = true;
  var _image;
  var imageUrl;
  var imagePicker;
  final _firebaseStorage = FirebaseStorage.instance;

  TextEditingController name = new TextEditingController();
  TextEditingController age = new TextEditingController();
  TextEditingController gender = new TextEditingController();
  TextEditingController mobileNo = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController numnerOfPeople = new TextEditingController();
  TextEditingController religion = new TextEditingController();
  TextEditingController numberOfRooms = new TextEditingController();

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
      }
    });
  }

  //Image Picker function to get image from camera
  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
      }
    });
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

  uploadImage() async {
    final _firebaseStorage = FirebaseStorage.instance;
    final imagePicker = ImagePicker();

    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      var image = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );
      setState(() {
        //  _image = File(image!.path);
      });
      var uid = Provider.of<Auth>(context, listen: false)
          .firebaseUser!
          .uid
          .toString();
      if (_image != null) {
        var snapshot = await _firebaseStorage
            .ref()
            .child('UserImages/$uid')
            .putFile(_image);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        if (mounted) {
          setState(() {
            imageUrl = downloadUrl;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
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
                      child: FutureBuilder(
                        future: Provider.of<UsersProvider>(context,
                                listen: false)
                            .getImageUrl(currUser!.uidUser.toString()),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return CircleAvatar(
                              radius: 60,
                              child:
                                  Image.network(snapshot.data.toString()),
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                        leading: Icon(
                          Icons.man_2_rounded,
                          color: Colors.pinkAccent,
                        ),
                        title: Text('Name: ${currUser!.nameUser}'),
                        trailing: Icon(
                          Icons.edit,
                          color: Colors.pinkAccent,
                        ),
                        onTap: () {
                          setState(() {
                            showModalBottomSheet(
                                isScrollControlled: true,
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
                                          padding:
                                              const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller: name,
                                            decoration: InputDecoration(
                                                hintText: "Name",
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius
                                                            .circular(20))),
                                                            keyboardType: TextInputType.name,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            newUser = currUser!.copyWith(
                                              nameUser:
                                                  name.text.toString(),
                                            );
                                            await Provider.of<
                                                        UsersProvider>(
                                                    context,
                                                    listen: false)
                                                .updateUsers(newUser!);
                                            setState(() {
                                                 currUser = newUser;
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
                          Icons.man,
                          color: Colors.pinkAccent,
                        ),
                        title: Text('Age: ${currUser!.ageUser}'),
                        trailing: Icon(
                          Icons.edit,
                          color: Colors.pinkAccent,
                        ),
                        onTap: () {
                          setState(() {
                            showModalBottomSheet(
                              isScrollControlled: true,
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
                                          padding:
                                              const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller: age,
                                            decoration: InputDecoration(
                                                hintText: "Age",
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius
                                                            .circular(20))),
                                                            keyboardType:TextInputType.number,
                                          ),
                                          
                                        ),
                                      ),
                                    Center(
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          newUser = currUser!.copyWith(
                                              ageUser: age.text.toString());
                                          await Provider.of<UsersProvider>(
                                                  context,
                                                  listen: false)
                                              .updateUsers(newUser!);
                                              setState(() {
                                                 currUser = newUser;
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
                          Icons.man,
                          color: Colors.pinkAccent,
                        ),
                        title: Text('Gender: ${currUser!.genderUser}'),
                        trailing: Icon(
                          Icons.edit,
                          color: Colors.pinkAccent,
                        ),
                        onTap: () {
                          setState(() {
                            showModalBottomSheet(
                              isScrollControlled: true,
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
                                          padding:
                                              const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller: gender,
                                            decoration: InputDecoration(
                                                hintText: "Gender",
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius
                                                            .circular(20))),
                                                            keyboardType:TextInputType.name,
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
                                          newUser = currUser!.copyWith(
                                            genderUser:
                                                gender.text.toString(),
                                          );

                                          await Provider.of<UsersProvider>(
                                                  context,
                                                  listen: false)
                                              .updateUsers(newUser!);
                                          setState(() {
                                                 currUser = newUser;
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
                          Icons.phone,
                          color: Colors.pinkAccent,
                        ),
                        title: Text(
                            'Mobile Number: ${currUser!.mobileNumberUser}'),
                        trailing: Icon(
                          Icons.edit,
                          color: Colors.pinkAccent,
                        ),
                        onTap: () {
                          setState(() {
                            showModalBottomSheet(
                              isScrollControlled: true,
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
                                          padding:
                                              const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller: mobileNo,
                                            decoration: InputDecoration(
                                                hintText: "Mobile No",
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius
                                                            .circular(20))),
                                                            keyboardType:TextInputType.phone,
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
                                          newUser = currUser!.copyWith(
                                            mobileNumberUser:
                                                mobileNo.text.toString(),
                                          );

                                          await Provider.of<UsersProvider>(
                                                  context,
                                                  listen: false)
                                              .updateUsers(newUser!);
                                          setState(() {
                                                 currUser = newUser;
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
                          Icons.house,
                          color: Colors.pinkAccent,
                        ),
                        title: Text('Address: ${currUser!.addressUser}'),
                        trailing: Icon(
                          Icons.edit,
                          color: Colors.pinkAccent,
                        ),
                        onTap: () {
                          setState(() {
                            showModalBottomSheet(
                              isScrollControlled: true,
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
                                          padding:
                                              const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller: address,
                                            decoration: InputDecoration(
                                                hintText: "Address",
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius
                                                            .circular(20))),
                                                            keyboardType:TextInputType.streetAddress,
                                          ),
                                          
                                        ),
                                      ),
                                    Center(
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          newUser = currUser!.copyWith(
                                            addressUser:
                                                address.text.toString(),
                                          );

                                          await Provider.of<UsersProvider>(
                                                  context,
                                                  listen: false)
                                              .updateUsers(newUser!);
                                           setState(() {
                                                 currUser = newUser;
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
                          Icons.work,
                          color: Colors.pinkAccent,
                        ),
                        title: Text(
                            'Number of people in the house:${currUser!.numberOfPeopleInhouseUser}'),
                        trailing: Icon(
                          Icons.edit,
                          color: Colors.pinkAccent,
                        ),
                        onTap: () {
                          setState(() {
                            showModalBottomSheet(
                              isScrollControlled: true,
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
                                          padding:
                                              const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller: numnerOfPeople,
                                            decoration: InputDecoration(
                                                hintText: "Number of people in the house",
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius
                                                            .circular(20))),
                                                            keyboardType:TextInputType.number,
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
                                          newUser = currUser!.copyWith(
                                              numberOfPeopleInhouseUser:
                                                  numnerOfPeople.text
                                                      .toString());

                                          await Provider.of<UsersProvider>(
                                                  context,
                                                  listen: false)
                                              .updateUsers(newUser!);
                                           setState(() {
                                                 currUser = newUser;
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
                  ],
                ),
              )),
        );
  }

  // Widget ProfileImage() {
  //   return ;
  // }

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

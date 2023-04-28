import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handyhive/Models/users.dart';
import 'package:handyhive/Provider/users_provider.dart';
import 'package:provider/provider.dart';

import '../../Provider/auth.dart';

class UserEditProfile extends StatefulWidget {
  const UserEditProfile({Key? key}) : super(key: key);

  @override
  State<UserEditProfile> createState() => _UserEditProfileState();
}

class _UserEditProfileState extends State<UserEditProfile> {
  Users? currUser;
  Users? newUser;
  bool _isInit = true;
  bool isLoading = true;
  TextEditingController name = new TextEditingController();
  TextEditingController age = new TextEditingController();
  TextEditingController gender = new TextEditingController();
  TextEditingController mobileNo = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController numnerOfPeople = new TextEditingController();
  TextEditingController religion = new TextEditingController();
  TextEditingController numberOfRooms = new TextEditingController();

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
                  print(currUser);

                  isLoading = false;
                });
              }));
    }
    _isInit = false;
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
                      CircleAvatar(
                        radius: 60,
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
                                      padding: MediaQuery.of(context).viewInsets,
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
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              newUser = currUser!.copyWith(
                                                nameUser: name.text.toString(),
                                              );
                                              await Provider.of<UsersProvider>(
                                                      context,
                                                      listen: false)
                                                  .updateUsers(newUser!);
                                              currUser = newUser;
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
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30.0),
                                      topRight: Radius.circular(30.0),
                                    ),
                                  ),
                                  builder: (context) {
                                    return Wrap(children: [
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
                                            currUser = newUser;
                                          },
                                          child: Text("UPDATE"),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.pinkAccent),
                                        ),
                                      )
                                    ]);
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
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30.0),
                                      topRight: Radius.circular(30.0),
                                    ),
                                  ),
                                  builder: (context) {
                                    return Wrap(children: [
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller: gender,
                                            decoration: InputDecoration(
                                                hintText: "Gender",
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20))),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            await Provider.of<Auth>(context,
                                                    listen: false)
                                                .getFirebaseUser();
                                            var uid = Provider.of<Auth>(context,
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
                                            currUser = newUser;
                                          },
                                          child: Text("UPDATE"),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.pinkAccent),
                                        ),
                                      )
                                    ]);
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
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30.0),
                                      topRight: Radius.circular(30.0),
                                    ),
                                  ),
                                  builder: (context) {
                                    return Wrap(children: [
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller: mobileNo,
                                            decoration: InputDecoration(
                                                hintText: "Mobile No",
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20))),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            await Provider.of<Auth>(context,
                                                    listen: false)
                                                .getFirebaseUser();
                                            var uid = Provider.of<Auth>(context,
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
                                            currUser = newUser;
                                          },
                                          child: Text("UPDATE"),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.pinkAccent),
                                        ),
                                      )
                                    ]);
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
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30.0),
                                      topRight: Radius.circular(30.0),
                                    ),
                                  ),
                                  builder: (context) {
                                    return Wrap(children: [
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
                                            currUser = newUser;
                                          },
                                          child: Text("UPDATE"),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.pinkAccent),
                                        ),
                                      )
                                    ]);
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
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30.0),
                                      topRight: Radius.circular(30.0),
                                    ),
                                  ),
                                  builder: (context) {
                                    return Wrap(children: [
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller: numnerOfPeople,
                                            decoration: InputDecoration(
                                                hintText:
                                                    "Number of people in the house",
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20))),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            await Provider.of<Auth>(context,
                                                    listen: false)
                                                .getFirebaseUser();
                                            var uid = Provider.of<Auth>(context,
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
                                            currUser = newUser;
                                            Navigator.pop(context);
                                          },
                                          child: Text("UPDATE"),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.pinkAccent),
                                        ),
                                      )
                                    ]);
                                  });
                            });
                          }),
                    ],
                  ),
                )),
          );
  }
}

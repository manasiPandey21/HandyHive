import 'package:flutter/material.dart';
import 'package:handyhive/Models/workers.dart';
import 'package:provider/provider.dart';

import '../../Provider/auth.dart';
import '../../Provider/workers_provider.dart';

class WorkerEditProfile extends StatefulWidget {
  const WorkerEditProfile({super.key});

  @override
  State<WorkerEditProfile> createState() => _WorkerEditProfileState();
}

class _WorkerEditProfileState extends State<WorkerEditProfile> {
  Worker? currWorker;
  Worker? newWorker;
  bool _isInit = true;
  bool isLoading = true;

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
                          title: Text('Name: ${currWorker!.nameWorkers}'),
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
                                            newWorker = currWorker!.copyWith(
                                              nameWorkers: name.text.toString(),
                                            );
                                            await Provider.of<WorkersProvider>(
                                                    context,
                                                    listen: false)
                                                .updateWorkers(newWorker!);
                                            currWorker = newWorker;
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
                          title: Text('Address: ${currWorker!.addressWorker}'),
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
                                          onPressed: () {
                                            onPressed:
                                            () async {
                                              newWorker = currWorker!.copyWith(
                                                nameWorkers:
                                                    name.text.toString(),
                                              );

                                              await Provider.of<
                                                          WorkersProvider>(
                                                      context,
                                                      listen: false)
                                                  .updateWorkers(newWorker!);
                                              currWorker = newWorker;
                                            };
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
                          title: Text('Age: ${currWorker!.ageworker}'),
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
                                                            20))), keyboardType:TextInputType.number,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            newWorker = currWorker!.copyWith(
                                                ageworker: age.text.toString());
                                            await Provider.of<WorkersProvider>(
                                                    context,
                                                    listen: false)
                                                .updateWorkers(newWorker!);
                                            currWorker = newWorker;
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
                          title: Text('Gender: ${currWorker!.genderworker}'),
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
                                            newWorker = currWorker!.copyWith(
                                              genderworker:
                                                  gender.text.toString(),
                                            );

                                            await Provider.of<WorkersProvider>(
                                                    context,
                                                    listen: false)
                                                .updateWorkers(newWorker!);
                                            currWorker = newWorker;
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
                              'Mobile Number: ${currWorker!.mobileNoworker}'),
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
                                                            20))), keyboardType:TextInputType.phone,
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
                                            newWorker = currWorker!.copyWith(
                                              mobileNoworker:
                                                  mobileNo.text.toString(),
                                            );

                                            await Provider.of<WorkersProvider>(
                                                    context,
                                                    listen: false)
                                                .updateWorkers(newWorker!);
                                            currWorker = newWorker;
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
                          title: Text(
                              'MaritalStatus:${currWorker!.maritalStatusworker}'),
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
                                            controller: maritalStatus,
                                            decoration: InputDecoration(
                                                hintText: "Marital Status",
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
                                            newWorker = currWorker!.copyWith(
                                              maritalStatusworker:
                                                  maritalStatus.text.toString(),
                                            );

                                            await Provider.of<WorkersProvider>(
                                                    context,
                                                    listen: false)
                                                .updateWorkers(newWorker!);
                                            currWorker = newWorker;
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
                              'WorkExperience:${currWorker!.workExperienceworker}'),
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
                                            controller: workExperience,
                                            decoration: InputDecoration(
                                                hintText: "Work Experience",
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20))), keyboardType:TextInputType.number,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            onPressed:
                                            () async {
                                              await Provider.of<Auth>(context,
                                                      listen: false)
                                                  .getFirebaseUser();
                                              var uid = Provider.of<Auth>(
                                                      context,
                                                      listen: false)
                                                  .firebaseUser!
                                                  .uid
                                                  .toString();
                                              newWorker = currWorker!.copyWith(
                                                  workExperienceworker:
                                                      workExperience.text
                                                          .toString());

                                              await Provider.of<
                                                          WorkersProvider>(
                                                      context,
                                                      listen: false)
                                                  .updateWorkers(newWorker!);
                                            };
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
                            Icons.language,
                            color: Colors.pinkAccent,
                          ),
                          title: Text('Language:${currWorker!.languageworker}'),
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
                                            controller: language,
                                            decoration: InputDecoration(
                                                hintText: "Language",
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
                                            newWorker = currWorker!.copyWith(
                                                languageworker:
                                                    language.text.toString());

                                            await Provider.of<WorkersProvider>(
                                                    context,
                                                    listen: false)
                                                .updateWorkers(newWorker!);
                                            currWorker = newWorker;
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
                )));
  }
}

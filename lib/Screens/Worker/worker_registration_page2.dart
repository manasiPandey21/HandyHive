import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:handyhive/Models/workers.dart';
import 'package:handyhive/Provider/workers_provider.dart';
import 'package:handyhive/Screens/Worker/worker_bottom_nav.dart';
import 'package:handyhive/Screens/Worker/worker_dashboard.dart';
import 'package:provider/provider.dart';

import '../../Provider/auth.dart';

class WorkerRegistrationPage2 extends StatefulWidget {
  const WorkerRegistrationPage2({Key? key}) : super(key: key);

  @override
  State<WorkerRegistrationPage2> createState() =>
      _WorkerRegistrationPage2State();
}

class _WorkerRegistrationPage2State extends State<WorkerRegistrationPage2> {
  Worker? currWorker;
  Worker? newWorker;
  bool _isInit = true;
  bool isLoading = true;
  var _hours = ['1', '2', '3', '4'];
  List<String> selectedHours = List.filled(9, '1');
  var _salary = ['500', '1000', '1500', '2000', '2500', '3000', '3500', '4000'];
  List<String> selectedSalary = List.filled(9, '500');
  Map<String, bool> selectedValues = {};
  List<Map<String, dynamic>> categories = [
    {"name": "Utensils Cleaning", "isChecked": false},
    {"name": "Clothes Cleaning", "isChecked": false},
    {"name": "Sweeping", "isChecked": false},
    {"name": "Cooking", "isChecked": false},
    {"name": "Brooming", "isChecked": false},
    {"name": "Gardening", "isChecked": false},
    {"name": "Elderly Care", "isChecked": false},
    {"name": "BabySitter", "isChecked": false},
    {"name": "Massager", "isChecked": false},
    {"name": "Ironing", "isChecked": false},
    {"name": "Driver", "isChecked": false},
    {"name": "nurse", "isChecked": false},
  ];

  List<Service> selectedServices = [];

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
        : WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    Text(
                      "Please select the jobs",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      height: 1,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        children: List.generate(categories.length, (index) {
                          final favourite = categories[index];
                          return CheckboxListTile(
                            title: Text(favourite["name"]),
                            value: favourite["isChecked"],
                            onChanged: (val) {
                              setState(() {
                                favourite["isChecked"] = val;
                              });
                            },
                            subtitle: favourite["isChecked"]
                                ? Row(
                                    children: [
                                      SizedBox(width: 50),
                                      Text("Hours: "),
                                      DropdownButton<String>(
                                        value: selectedHours[index],
                                        items: _hours.map((hour) {
                                          return DropdownMenuItem<String>(
                                            value: hour,
                                            child: Text(hour),
                                          );
                                        }).toList(),
                                        onChanged: (val) {
                                          setState(() {
                                            selectedHours[index] = val!;
                                          });
                                        },
                                      ),
                                      SizedBox(width: 40),
                                      Text("Salary: "),
                                      DropdownButton<String>(
                                        value: selectedSalary[index],
                                        items: _salary.map((salary) {
                                          return DropdownMenuItem<String>(
                                            value: salary,
                                            child: Text(salary),
                                          );
                                        }).toList(),
                                        onChanged: (val) {
                                          setState(() {
                                            selectedSalary[index] = val!;
                                          });
                                        },
                                      ),
                                    ],
                                  )
                                : null,
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      height: 1,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        for (int i = 0; i < categories.length; i++) {
                          if (categories[i]["isChecked"] == true) {
                            final service = Service(
                              name: categories[i]["name"],
                              hours: selectedHours[i],
                              salary: selectedSalary[i],
                            );
                            selectedServices.add(service);
                          }
                        }
                        print(currWorker);
                        newWorker =
                            currWorker!.copyWith(service: selectedServices);
                        print(newWorker);

                        await Provider.of<WorkersProvider>(context,
                                listen: false)
                            .updateWorkers(newWorker!);
                        currWorker = newWorker;

                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) {
                          return  WorkerBottomNavigation();
                        }), (route) => false);
                      },
                      child: Text("Submit"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent,
                      ),
                    ),
                    Wrap(
                      children: categories.map((favourite) {
                        if (favourite["isChecked"] == true) {
                          return Card(
                            elevation: 3,
                            color: Colors.pinkAccent,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    favourite["name"],
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        favourite["isChecked"] =
                                            !favourite["isChecked"];
                                      });
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return Container();
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

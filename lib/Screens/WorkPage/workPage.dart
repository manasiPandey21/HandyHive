import 'package:flutter/material.dart';

class WorkPages extends StatefulWidget {
  const WorkPages({super.key});

  @override
  State<WorkPages> createState() => _WorkPagesState();
}

class _WorkPagesState extends State<WorkPages> {
  List<Map> categories = [
    {"name": "utensils cleaning", "isChecked": false},
    {"name": "sweeping", "isChecked": false},
    {"name": "cooking", "isChecked": false},
    {"name": "Gardening", "isChecked": false},
    {"name": "nurse", "isChecked": false},
    {"name": "Elderly care", "isChecked": false},
    {"name": "BabySitter", "isChecked": false},
    {"name": "Pateint care", "isChecked": false},
    {"name": "Massager", "isChecked": false},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            Text(
              "Please select the jobs",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold ),
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
                  children: categories.map((favourite) {
                return CheckboxListTile(
                  
                    title: Text(favourite["name"]),
                    value: favourite["isChecked"],
                    onChanged: (val) {
                      setState(() {
                        favourite["isChecked"] = val;
                      });
                    });
              }).toList()),
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
                                favourite["isChecked"] =!favourite["isChecked"];
                              });
                            },
                            child: Icon(Icons.delete, color: Colors.white),
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
    );
  }
}

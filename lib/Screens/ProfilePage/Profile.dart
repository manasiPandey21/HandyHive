import 'dart:io';

import 'package:flutter/material.dart';
import 'package:handyhive/Screens/WorkPage/workPage.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  final picker = ImagePicker();

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
    return Scaffold(
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
          profileimage(),
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
              decoration: InputDecoration(
                labelText: "LANGUAGE",
                // hintText: "Manasi",
                border: InputBorder.none,
              ),
            ),
          ),
          ElevatedButton(onPressed: (){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const WorkPages(),
              ),
            );
          }, child: Text("Submit"),style:ElevatedButton.styleFrom(
            backgroundColor: Colors.pinkAccent,
            shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(40))
          ),)
        ],
      )),
    );
  }

  Widget profileimage() {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 80,
            backgroundImage:
            
                _image != null ? FileImage(File(_image!.path)) : AssetImage("assets/mansi.jpeg") as ImageProvider,
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

import 'package:flutter/material.dart';
class EditProfileUser extends StatefulWidget {
  const EditProfileUser({super.key});

  @override
  State<EditProfileUser> createState() => _EditProfileUserState();
}

class _EditProfileUserState extends State<EditProfileUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Profile"),),
    );
  }
}
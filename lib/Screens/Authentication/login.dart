import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:handyhive/Screens/Authentication/otp.dart';
import 'package:provider/provider.dart';
import 'package:handyhive/Provider/auth.dart';

import '../Common/load.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  static String verify = "";
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController phone = TextEditingController();
  bool showLoading = false;

  String? validatePhoneNumber(String value) {
    if (value.length != 10) {
      return 'Phone number must have exactly 10 digits';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return showLoading
        ? LoadScreen()
        : Scaffold(
            body: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/xyz.png", width: 170, height: 170),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Phone Verification",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Please sign up your phone before getting started",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.ideographic,
                          children: [
                            Icon(Icons.phone),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                controller: phone,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter your phone number",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter a mobile number";
                                  } else if (value.length != 10) {
                                    return "Please enter a valid Mobile number";
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 45,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              showLoading = true;
                            });
                            if (_formKey.currentState!.validate()) {
                              await Provider.of<Auth>(context, listen: false)
                                  .submitPhoneNumber(
                                      phone.text.toString(), context);
                            }
                          },
                          child: Text("Send OTP"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.pink.shade500,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

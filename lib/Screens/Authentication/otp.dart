import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import 'package:handyhive/Screens/Authentication/login.dart';
import 'package:provider/provider.dart';

import '../../Provider/auth.dart';
import '../OnBoardingScreen/landing_page.dart';
import '../User/user_dashboard.dart';

import '../Worker/worker_dashboard.dart';

class MyOtp extends StatefulWidget {
  const MyOtp({super.key});

  @override
  State<MyOtp> createState() => _MyOtpState();
}

class _MyOtpState extends State<MyOtp> {
  @override
  bool? islogintrue;
  final FirebaseAuth auth = FirebaseAuth.instance;
  var code1 = "";
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
        alignment: Alignment.center,
        child: SingleChildScrollView(
            child: Column(
          children: [
            Text(
              "Verification Code",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Enter the OTP sent to +91-95551663"),
            SizedBox(
              height: 20,
            ),
            OtpTextField(
              numberOfFields: 6,
              borderColor: Color(0xFF512DA8),
              showFieldAsBox: true,
              onCodeChanged: (String code) {
                code1 = code;
              },
              onSubmit: (String verificationCode) async {
                islogintrue = await Provider.of<Auth>(context, listen: false)
                    .submitOTP(verificationCode);

                Auth.setUid();

                var isuser = await FirebaseFirestore.instance
                    .collection('USERS')
                    .doc(Auth.uid)
                    .get();
                var isworker = await FirebaseFirestore.instance
                    .collection('WORKERS')
                    .doc(Auth.uid)
                    .get();

                if (islogintrue == true) {
                  if (isuser.exists) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const UserDashBoard(),
                    ));
                  } else if (isworker.exists) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const WorkerDashBoard(),
                    ));
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LandingPage(),
                      ),
                    );
                  }
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                  );
                }
                // showDialog(
                //     context: context,
                //     builder: (context) {
                //       return AlertDialog(
                //         title: Text("Verification Code"),
                //         content: Text('Code entered is $verificationCode'),
                //       );
                //     });
              }, // end onSubmit
            ),
            SizedBox(
              height: 60,
            ),
            Text("Resend in 00.05 sec"),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.check_box,
                  color: Colors.pinkAccent,
                ),
                Text(
                  "I agree to HandsHive's Terms & Conditions & Privacy Policy",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
          ],
        )),
      ),
    );
  }
}

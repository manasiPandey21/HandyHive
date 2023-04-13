import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:handyhive/Screens/Landing_Page/landingPage.dart';
import 'package:handyhive/Screens/ProfilePage/Profile.dart';
import 'package:handyhive/Screens/authenticate/Sign_up.dart';
import 'package:provider/provider.dart';

import '../../Provider/auth.dart';

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
              //set to true to show as box or false to show as dash
              showFieldAsBox: true,
              //runs when a code is typed in
              onCodeChanged: (String code) {
                //handle validation or checks here
                code1 = code;
              },
              //runs when every textfield is filled
              onSubmit: (String verificationCode) async {
              
                islogintrue =
                        await Provider.of<Auth>(context, listen: false)
                            .submitOTP(verificationCode);
                   
                    Auth.setUid();

                    if (islogintrue == true) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, "Profile page", (Route) => false);
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const landing(),
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
            // SizedBox(
            //     height: 45,
            //     width: double.infinity,
            //     child: ElevatedButton(
            //       onPressed: () async {
            //         islogintrue =
            //             await Provider.of<Auth>(context, listen: false)
            //                 .submitOTP(code1);
            //         print(islogintrue);
            //         Auth.setUid();

            //         if (islogintrue == true) {
            //           Navigator.pushNamedAndRemoveUntil(
            //               context, "Profile page", (Route) => false);
            //         } else {
            //           Navigator.of(context).push(
            //             MaterialPageRoute(
            //               builder: (context) => const landing(),
            //             ),
            //           );
            //         }

            //         // try {
            //         //   PhoneAuthCredential credential =
            //         //       PhoneAuthProvider.credential(
            //         //           verificationId: Sign_up.verify, smsCode: code1);

            //         //   // Sign the user in (or link) with the credential
            //         //   await auth.signInWithCredential(credential);
            //         //   Navigator.pushNamedAndRemoveUntil(
            //         //       context, "Profile page", (Route) => false);
            //         // } catch (e) {
            //         //   print("wrong otp");
            //         // }

            //         // Navigator.of(context).push(
            //         //   MaterialPageRoute(
            //         //     builder: (context) => const landing(),
            //         //   ),
            //         // );
            //       },
            //       child: Text("Continue"),
            //       style: ElevatedButton.styleFrom(
            //           primary: Colors.pink.shade500,
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(10),
            //           )),
            //     ))
          ],
        )),
      ),
    );
  }
}

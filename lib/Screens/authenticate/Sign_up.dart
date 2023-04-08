import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:handyhive/Screens/authenticate/otp.dart';

class Sign_up extends StatefulWidget {
  const Sign_up({super.key});
  static String verify = "";
  @override
  State<Sign_up> createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  @override
  TextEditingController phone = TextEditingController();
  //var phone = "";
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/xyz.png", width: 170, height: 170),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Phone Verification",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text("Please sign up your phone before getting started",
                        style: TextStyle(fontSize: 16)),
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
                        children: [
                          SizedBox(
                            width: 40,
                            // child: TextField(
                           
                            //   decoration: InputDecoration(
                            //       border: InputBorder.none, hintText: "+91"),
                            // ),
                          ),
                          SizedBox(
                            width: 1,
                          ),
                          Expanded(
                            child: SizedBox(
                                width: 40,
                                child: TextField(
                                     controller: phone,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "9555181663"),
                                )),
                          )
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
                            print('+91${ phone.text}');
                            await FirebaseAuth.instance.verifyPhoneNumber(
                              phoneNumber:'+91${phone.text}',
                              verificationCompleted:
                                  (PhoneAuthCredential credential) {},
                              verificationFailed: (FirebaseAuthException e) {},
                              codeSent:
                                  (String verificationId, int? resendToken) {
                                Sign_up.verify = verificationId;
                                Navigator.pushNamed(context, "otp");
                              },
                              codeAutoRetrievalTimeout:
                                  (String verificationId) {},
                            );
                            //               Navigator.of(context).push(
                            // MaterialPageRoute(
                            //   builder: (context) => const MyOtp(),
                            // ),
                            // );
                          },
                          child: Text("Send OTP"),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.pink.shade500,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ))
                  ]),
            )));
  }
}

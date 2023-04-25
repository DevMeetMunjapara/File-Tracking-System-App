import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fts/customwidget/fullbutton.dart';
import 'package:fts/login/otpscreen.dart';

class phoneverification extends StatefulWidget {
  phoneverification({super.key});

  static String verify = "";

  @override
  State<phoneverification> createState() => _phoneverificationState();
}

class _phoneverificationState extends State<phoneverification> {
  final GlobalKey<FormState> _mobileKey = GlobalKey<FormState>();
  TextEditingController _mobileNumber = TextEditingController();
  var phone = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mobileNumber.addListener(
      () => setState(() {}),
    );
  }

  @override
  bool loading = false;

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 90,
              ),
              const Image(
                image: AssetImage("img/login/mobileNumber.png"),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Phone Verfication",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "We need to register your phone number before getting started!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _mobileKey,
                child: TextFormField(
                  onTap: () {
                    _mobileNumber.text = "+91".toString();
                  },
                  controller: _mobileNumber,
                  keyboardType: TextInputType.number,
                  cursorColor: PrimaryColor,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: PrimaryColor),
                      borderRadius: BorderRadius.circular(5.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: PrimaryColor),
                      borderRadius: BorderRadius.circular(5.5),
                    ),
                    prefixIcon: Icon(
                      Icons.phone,
                      color: PrimaryColor,
                    ),
                    hintText: "Enter Mobile Number",
                    hintStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    filled: true,
                    fillColor: Color.fromARGB(255, 231, 231, 231),
                  ),
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return "Enter Mobile Number";
                    }
                    if (value.length < 10) {
                      return 'Mobile Number Must Be 10 Digits!';
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const SizedBox(
                height: 20,
              ),
              FullButton(
                title: "Send OTP",
                loading: loading,
                onPressed: () async {
                  if (_mobileKey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: '${_mobileNumber.text + phone}',
                      verificationCompleted:
                          (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException e) {},
                      codeSent: (String verificationId, int? resendToken) {
                        phoneverification.verify = verificationId;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => otpscreen()));
                        setState(() {
                          loading = false;
                        });
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

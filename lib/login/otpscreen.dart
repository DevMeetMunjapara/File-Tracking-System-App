import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fts/customwidget/fullbutton.dart';
import 'package:fts/home.dart';
import 'package:fts/login/phoneverification.dart';
import 'package:fts/splash/splashScreen.dart';
import 'package:fts/splash/splashServices.dart';
import 'package:pinput/pinput.dart';

class otpscreen extends StatefulWidget {
  const otpscreen({Key? key}) : super(key: key);

  @override
  State<otpscreen> createState() => _otpscreenState();
}

class _otpscreenState extends State<otpscreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  bool loading = false;
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    var code = "";

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'img/login/OTP.png',
                width: 300,
                height: 200,
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "We need to register your phone without getting started!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Pinput(
                length: 6,
                // defaultPinTheme: defaultPinTheme,
                // focusedPinTheme: focusedPinTheme,
                // submittedPinTheme: submittedPinTheme,
                showCursor: true,
                onChanged: (value) {
                  code = value;
                },
                onCompleted: (pin) => print(pin),
              ),
              const SizedBox(
                height: 20,
              ),
              FullButton(
                title: "Verify Phone Number",
                loading: loading,
                onPressed: () async {
                  try {
                    setState(() {
                      loading = true;
                    });
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: phoneverification.verify,
                            smsCode: code);

                    // Sign the user in (or link) with the credential
                    await auth.signInWithCredential(credential);
                    // ignore: use_build_context_synchronously
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => SplashScreen()),
                        (route) => false);

                    setState(() {
                      loading = false;
                    });
                  } catch (e) {
                    print("Wrong OTP");
                  }
                  setState(() {
                    loading = false;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

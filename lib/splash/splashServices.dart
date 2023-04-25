import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fts/home.dart';
import 'package:fts/login/phoneverification.dart';

var loginMobileNumber = "+919409497905";

class SplashServices {
  void isLogin(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;
    // loginMobileNumber = user?.phoneNumber;
    if (user != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => phoneverification()));
    }
  }
}

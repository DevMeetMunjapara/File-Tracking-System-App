import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fts/customwidget/fullbutton.dart';
import 'package:fts/home.dart';
import 'package:fts/login/phoneverification.dart';
import 'package:fts/page/completeFile.dart';
import 'package:fts/page/profile.dart';
import 'package:fts/page/totalFile.dart';
import 'package:fts/splash/splashServices.dart';

Color PrimaryColor = const Color.fromARGB(255, 84, 22, 208);

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.only(top: 40, bottom: 15),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: PrimaryColor,
                ),
                child: Column(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 49,
                      child: CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.green,
                        backgroundImage: AssetImage("img/home/man.png"),
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      loginMobileNumber,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                )),
            ListTile(
                leading: const Icon(Icons.person),
                iconColor: Colors.black,
                title: const Text('Profile'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()));
                }),
            ListTile(
              leading: const Icon(Icons.file_copy),
              iconColor: Colors.black,
              title: const Text('Total File'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TotalFile()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.file_download_done),
              iconColor: Colors.black,
              title: const Text('Complete File'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CompleteFile()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              iconColor: Colors.black,
              title: const Text('LogOut'),
              onTap: () async {
                await auth.signOut().then((value) =>
                    Navigator.pushAndRemoveUntil(
                        context as BuildContext,
                        MaterialPageRoute(
                            builder: (context) => phoneverification()),
                        (route) => false));
              },
            ),
          ],
        ),
      ),
    );
  }
}

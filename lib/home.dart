import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fts/customwidget/drawer.dart';
import 'package:fts/customwidget/fullbutton.dart';
import 'package:fts/customwidget/notificationService.dart';
import 'package:fts/main.dart';
import 'package:fts/page/completeFile.dart';
import 'package:fts/page/fileStatus.dart';
import 'package:fts/page/notification.dart';
import 'package:fts/page/pendingFile.dart';
import 'package:fts/page/rejectFile.dart';

import 'package:fts/splash/splashServices.dart';
import 'package:fts/page/totalFile.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color PrimaryColor = Color.fromARGB(255, 84, 22, 208);

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  GlobalKey<FormState> TrackingFrom = GlobalKey<FormState>();

  TextEditingController trakingId = TextEditingController();

  bool loading = false;
  int myIndex = 0;
  int notificationCount = -1;
  List<Widget> list = [
    Home(),
    RejectFile(),
  ];
  int totalFile = 0;
  int completeFileCount = 0;
  void getFileCount() {
    final countDocs = FirebaseFirestore.instance
        .collection("allUser")
        .doc(loginMobileNumber)
        .collection("allFile")
        .get()
        .then((value) => {
              totalFile = value.size,
              print(totalFile),
            });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotificationCount();
    getFileCount();
  }

  void getNotificationCount() {
    print("object");
    // int a = 5;
    // var perfs = await SharedPreferences.getInstance();
    // perfs.setString("notificationCount", a.toString());
    // var count = perfs.getString("notificationCount");
    // print("---$count");

    Stream<QuerySnapshot<Map<String, dynamic>>> notificationSterem =
        FirebaseFirestore.instance
            .collection("allUser")
            .doc(loginMobileNumber)
            .collection("notification")
            .snapshots();

    StreamSubscription<QuerySnapshot<Map<String, dynamic>>> streamSubscriptio =
        notificationSterem.listen((event) {
      if (event.docs.isEmpty) {
        return;
      }
      print(event.docs);
      notificationCount += 1;
      print(notificationCount);
      var newFileAdd = event.docs.last.id;
      NotificationWidget.showNotificationOnFirebase(
          title: "New File Add", body: "the New File Name is $newFileAdd");
    });
  }

  @override
  Widget build(BuildContext context) {
    print(loginMobileNumber);
    return Scaffold(
      appBar: AppBar(
        title: Text("FTS"),
        centerTitle: true,
        backgroundColor: PrimaryColor,
        toolbarHeight: 70,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        )),
        leading: Padding(
            padding: EdgeInsets.only(left: 15),
            child: Builder(builder: (context) {
              return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(Icons.person));
            })),
      ),
      drawer: Drawer(child: MyDrawer()),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TotalFile(
                                //allFileCount: totalFile,
                                )));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 207, 166, 255),
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                            color: Color.fromARGB(255, 110, 12, 223))),
                    padding: EdgeInsets.all(5),
                    height: 80,
                    width: 75,
                    child: Column(
                      children: const [
                        Image(
                          image: AssetImage("img/home/allFile.png"),
                          height: 25,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Total \n File")
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CompleteFile()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 134, 249, 182),
                        borderRadius: BorderRadius.circular(7),
                        border:
                            Border.all(color: Color.fromARGB(255, 2, 99, 54))),
                    padding: EdgeInsets.all(5),
                    height: 80,
                    width: 75,
                    child: Column(
                      children: const [
                        Image(
                          image: AssetImage("img/home/complete.png"),
                          height: 25,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Approved \n File",
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PendingFile()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 245, 255, 166),
                        borderRadius: BorderRadius.circular(7),
                        border:
                            Border.all(color: Color.fromARGB(255, 110, 96, 4))),
                    padding: EdgeInsets.all(5),
                    height: 80,
                    width: 75,
                    child: Column(
                      children: const [
                        Image(
                          image: AssetImage("img/home/pending.png"),
                          height: 25,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Process \n File",
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RejectFile()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 207, 166, 255),
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                            color: Color.fromARGB(255, 110, 12, 223))),
                    padding: EdgeInsets.all(5),
                    height: 80,
                    width: 75,
                    child: Column(
                      children: const [
                        Image(
                          image: AssetImage("img/home/reject.png"),
                          height: 25,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Reject \n File",
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.black, width: 1.5)),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Form(
                        key: TrackingFrom,
                        child: TextFormField(
                          controller: trakingId,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: "Enter Taracking ID",
                            hintStyle: TextStyle(color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 84, 22, 208))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 84, 22, 208))),
                            prefixIcon: Icon(
                              Icons.location_pin,
                              color: Color.fromARGB(255, 84, 22, 208),
                            ),
                            filled: true,
                          ),
                          validator: (val) {
                            if (val == "") {
                              return "Enter Traking ID";
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FullButton(
                          title: "Track File",
                          loading: loading,
                          onPressed: () {
                            if (TrackingFrom.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FileStatus(
                                          trckingId: trakingId.text)));
                              setState(() {
                                loading = false;
                              });
                            }
                          }),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

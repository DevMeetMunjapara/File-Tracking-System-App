import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fts/customwidget/fileStatusIcon.dart';
import 'package:fts/customwidget/fullbutton.dart';
import 'package:fts/customwidget/notificationService.dart';
import 'package:fts/splash/splashServices.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'fileStatus.dart';

class MyNotification extends StatefulWidget {
  const MyNotification({super.key});

  @override
  State<MyNotification> createState() => _MyNotificationState();
}

class _MyNotificationState extends State<MyNotification> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotificationWidget.init();
    // demo();
    getNotificationCount();
  }

  void getNotificationCount() async {
    print("object");
    int a = 15;
    var perfs = await SharedPreferences.getInstance();
    perfs.setString("notificationCount", a.toString());
    var count = await perfs.getString("notificationCount");
    print(count);
  }

  void demo() {
    Stream<QuerySnapshot<Map<String, dynamic>>> notificationSterem =
        FirebaseFirestore.instance
            .collection("allUser")
            .doc(loginMobileNumber)
            .collection("allFile")
            .snapshots();

    StreamSubscription<QuerySnapshot<Map<String, dynamic>>> streamSubscriptio =
        notificationSterem.listen((event) {
      if (event.docs.isEmpty) {
        return;
      }
      print(event.docs.last.id);
      var newFileAdd = event.docs.last.id;
      NotificationWidget.showNotificationOnFirebase(
          title: "New File Add", body: "the New File Name is $newFileAdd");
    });
  }

  // void showNotification(QueryDocumentSnapshot<Map<String, dynamic>> event) {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails(
  //     '001',
  //     'Local Notifiaction',
  //     channelDescription: "TO send local Notification",
  //     importance: Importance.max,
  //   );
  //   const NotificationDetails details =
  //       NotificationDetails(android: androidNotificationDetails);
  //   flutterLocalNotificationsPlugin.show(
  //       01, event.get("fileName"), event.get("fileStatus"));
  // }

  var db = FirebaseFirestore.instance
      .collection("allUser")
      .doc(loginMobileNumber)
      .collection("notification")
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Notification",
          ),
          backgroundColor: PrimaryColor,
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: Container(
            child: StreamBuilder(
              stream: db,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    int a = 15;

                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                  color: Color.fromARGB(255, 0, 0, 0))),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 70, 68, 68),
                                child: FileStatusIcon(
                                    setSize: 25.toDouble(),
                                    fileStatus: snapshot.data!.docs[index]
                                        ["fileStatus"]),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data!.docs[index]
                                        ["lastUpdateDate"],
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "File ID :- " +
                                        snapshot.data!.docs[index]
                                            ["TrackingId"],
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "Update Time:- " +
                                        snapshot.data!.docs[index]
                                            ["lastUpdateTime"],
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: PrimaryColor),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FileStatus(
                                                      trckingId: snapshot
                                                              .data!.docs[index]
                                                          ["TrackingId"],
                                                    )));
                                      },
                                      child: const Text(
                                        "Track File",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ));
  }
}

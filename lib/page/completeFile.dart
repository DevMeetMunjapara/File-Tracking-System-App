import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fts/customwidget/drawer.dart';
import 'package:fts/customwidget/fileStatusIcon.dart';
import 'package:fts/customwidget/infoStatus.dart';
import 'package:fts/page/fileStatus.dart';
import 'package:fts/splash/splashServices.dart';

class CompleteFile extends StatefulWidget {
  const CompleteFile({super.key});

  @override
  State<CompleteFile> createState() => _CompleteFileState();
}

class _CompleteFileState extends State<CompleteFile> {
  final db = FirebaseFirestore.instance
      .collection("allUser")
      .doc(loginMobileNumber)
      .collection("allFile")
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Approved File"),
          backgroundColor: PrimaryColor,
        ),
        body: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Container(
              child: Column(
                children: [
                  InfoStatus(),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: db,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text(
                              "Some Error",
                              style: TextStyle(fontSize: 16),
                            ),
                          );
                        }
                        int count = 0;
                        if (snapshot.hasData) {
                          for (var i = 0; i < snapshot.data!.docs.length; i++) {
                            if (snapshot.data!.docs[i]["fileStatus"]
                                    .toString() ==
                                "Approved") {
                              count += 1;

                              print("----------" + count.toString());
                            }
                          }

                          if (count == 0) {
                            return Center(
                                child: Padding(
                                    padding:
                                        EdgeInsetsDirectional.only(top: 20),
                                    child: Column(
                                      children: const [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        CircleAvatar(
                                          backgroundColor: Color.fromARGB(
                                              255, 199, 199, 199),
                                          radius: 50,
                                          child: Image(
                                              height: 50,
                                              width: 50,
                                              image: AssetImage(
                                                  "img/home/notExit.png")),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "Not Any Approved File",
                                          style: TextStyle(
                                              fontSize: 18, color: Colors.red),
                                        )
                                      ],
                                    )));
                          } else {
                            return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                if (snapshot.data!.docs[index]["fileStatus"]
                                        .toString() ==
                                    "Approved") {
                                  return Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Card(
                                        elevation: 15,
                                        child: Padding(
                                          padding: EdgeInsets.all(15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    snapshot.data!.docs[index]
                                                        .reference.id
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  FileStatusIcon(
                                                    fileStatus: snapshot
                                                            .data!.docs[index]
                                                        ["fileStatus"],
                                                    setSize: 25.toDouble(),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  const Text(
                                                    "File Name :- ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    snapshot.data!
                                                        .docs[index]["fileName"]
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Text(
                                                    "File Submit Date :- ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    snapshot
                                                        .data!
                                                        .docs[index]
                                                            ["submitDate"]
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              PrimaryColor),
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    FileStatus(
                                                                      trckingId: snapshot
                                                                          .data!
                                                                          .docs[
                                                                              index]
                                                                          .reference
                                                                          .id
                                                                          .toString(),
                                                                    )));
                                                  },
                                                  child: const Text(
                                                    "Trak File",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ))
                                            ],
                                          ),
                                        )),
                                  );
                                } else {
                                  return SizedBox.shrink();
                                }
                              },
                            );
                          }
                        }
                        return SizedBox.shrink();
                        //
                      },
                    ),
                  ),
                ],
              ),
            )));
  }
}

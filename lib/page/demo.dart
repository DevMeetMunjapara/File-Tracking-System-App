import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fts/customwidget/drawer.dart';

import '../customwidget/fileStatusIcon.dart';
import '../splash/splashServices.dart';

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  var fileData = FirebaseFirestore.instance
      .collection("allUser")
      .doc("+919409497905")
      .collection("allFile");
  int index = 0;
  String trckingId = "FTS20232";
  @override
  Widget build(BuildContext context) {
    print(loginMobileNumber);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo"),
        backgroundColor: PrimaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(4),
        child: Stepper(
          currentStep: index,
          onStepTapped: (value) {
            setState(() {
              index = value;
            });
          },
          controlsBuilder: (context, details) {
            return SizedBox.shrink();
          },
          steps: [
            Step(
                title: Text(
                  "Current File Status / Information",
                  style: TextStyle(fontSize: 20, color: PrimaryColor),
                ),
                isActive: index == 0,
                content: FutureBuilder(
                  future: fileData.doc("FTS20232").get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Center(
                            child: Text(
                          "File Data Not Exsit",
                          textScaleFactor: 1.5,
                          style: TextStyle(color: Colors.red),
                        )),
                      );
                    }
                    print(snapshot);
                    if (snapshot.data == null) {
                      return Text("No Data Available ");
                    }
                    if (snapshot.hasData && !snapshot.data!.exists) {
                      return Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Center(
                            child: Column(
                          children: const [
                            Image(
                              image: AssetImage("img/home/notFound.png"),
                              height: 90,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "File Not Found",
                              textScaleFactor: 1.7,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        )),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;
                      print(data);
                      return Padding(
                        padding: EdgeInsets.only(top: 0, left: 0, right: 0),
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 2.5,
                                      ),
                                    ]),
                                width: double.infinity,
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      showFileData("Tracking Id",
                                          snapshot.data!.reference.id),
                                      showFileData(
                                          "File Name", data["fileName"]),
                                      // Show Costom Data
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 15, 10, 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "File Status",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  data["fileStatus"],
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                FileStatusIcon(
                                                  fileStatus:
                                                      data["fileStatus"],
                                                  setSize: 25.toDouble(),
                                                ),
                                              ],
                                            ),
                                            const Divider(
                                              thickness: 1,
                                              color: Colors.black,
                                            )
                                          ],
                                        ),
                                      ),
                                      //End Costom Data
                                      showFileData("Last Update",
                                          data["lastUpdateReason"]),
                                      showFileData("Last Update Data & Time",
                                          "${data["lastUpdateDate"] + "  " + data["lastUpdateTime"]}"),
                                      showFileData("Current File In Department",
                                          data["currentDepartment"]),
                                      showFileData(
                                          "Current File In Sub Department",
                                          data["currentSubDepartment"]),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "File Detials",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 60, 102, 219),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 2.5,
                                      ),
                                    ]),
                                width: double.infinity,
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      showFileData(
                                          "File Name", data["fileName"]),
                                      showFileData(
                                          "File Colour", data["colour"]),
                                      showFileData(
                                          "File Page", data["totalPages"]),
                                      showFileData("File Submite Date",
                                          data["submitDate"]),
                                      showFileData("File Submite Date & Time",
                                          "${data["submitDate"] + "  " + data["submitTime"]}"),
                                      showFileData("Submit File In Department",
                                          data["submitDepartment"]),
                                      showFileData(
                                          "Submit File In Sub Department",
                                          data["submitSubDepartment"]),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "File Owner Detials",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 60, 102, 219),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 2.5,
                                      ),
                                    ]),
                                width: double.infinity,
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      showFileData("Owner Name", data["name"]),
                                      showFileData("Owner Phone Number",
                                          data["mobileNumber"]),
                                      showFileData(
                                          "Owner Email", data["email"]),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return CircularProgressIndicator();
                  },
                )),
            Step(
              title: Text("data"),
              isActive: index == 1,
              content: Text("data"),
            ),
          ],
        ),
      ),
    );
  }
}

Widget showFileData(String title, String fileData, {IconData}) {
  return Padding(
    padding: EdgeInsets.fromLTRB(10, 15, 10, 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 17,
              color: Color.fromARGB(255, 0, 140, 255),
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          fileData,
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const Divider(
          thickness: 1,
          color: Colors.black,
        )
      ],
    ),
  );
}

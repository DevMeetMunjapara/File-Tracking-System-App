import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fts/customwidget/drawer.dart';
import 'package:fts/page/profileController.dart';
import 'package:fts/home.dart';
import 'package:fts/splash/splashScreen.dart';
import 'package:fts/splash/splashServices.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController MobileNumberController = TextEditingController();
  TextEditingController NameController = TextEditingController();
  TextEditingController EmailController = TextEditingController();

  GlobalKey<FormState> form = GlobalKey<FormState>();
  final db = FirebaseFirestore.instance
      .collection("allUser")
      .doc(loginMobileNumber)
      .get()
      .then((value) {
    print(value);
  });

  final ButtonStyle style = ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 50),
    //color: Colors.green,
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  String name = "";
  String email = "";

  getdata() async {
    final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection("allUser")
        .doc(loginMobileNumber)
        .get();
    final data = documentSnapshot;
    print(data["name"]);
    print(data["email"]);
    setState(() {
      NameController.text = data["name"];
      EmailController.text = data["email"];
      MobileNumberController.text = data["mobileNumber"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 84, 22, 208),
          elevation: 1,
          title: Text("Profile"),
        ),
        body: ChangeNotifierProvider(
          create: (_) => ProfileController(),
          child: Consumer<ProfileController>(
            builder: (context, provider, child) {
              return Container(
                padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: ListView(
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Center(
                              child: Container(
                                height: 130,
                                width: 130,
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius: 2,
                                          blurRadius: 10,
                                          color: Colors.blue.withOpacity(0.1),
                                          offset: const Offset(0, 10))
                                    ],
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 2,
                                      color: (Colors.white),
                                    )),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: provider.image == null
                                      ? Container(
                                          decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image:
                                                AssetImage('img/home/man.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ))
                                      : Image.file(
                                          File(provider.image!.path).absolute),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              provider.pickImage(context);
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 2,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                color: const Color.fromARGB(255, 84, 22, 208),
                              ),
                              child: const Icon(
                                Icons.add,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Center(
                      //   child: Stack(
                      //     alignment: Alignment.bottomCenter,
                      //     children: [
                      //       provider.image == null
                      //           ? Container(
                      //               width: 130,
                      //               height: 130,
                      //               decoration: BoxDecoration(
                      //                   border: Border.all(
                      //                       width: 4,
                      //                       color: Theme.of(context)
                      //                           .scaffoldBackgroundColor),
                      //                   boxShadow: [
                      //                     BoxShadow(
                      //                         spreadRadius: 2,
                      //                         blurRadius: 10,
                      //                         color:
                      //                             Colors.blue.withOpacity(0.1),
                      //                         offset: Offset(0, 10))
                      //                   ],
                      //                   shape: BoxShape.circle,
                      //                   image: DecorationImage(
                      //                       fit: BoxFit.cover,
                      //                       image: AssetImage(
                      //                           "img/home/man.png"))),
                      //             )
                      //           : Image.file(
                      //               File(provider.image!.path).absolute),
                      //       InkWell(
                      //           onTap: () {
                      //             provider.pickImage(context);
                      //           },
                      //           // bottom: 0,
                      //           // right: 0,
                      //           child: Container(
                      //             height: 40,
                      //             width: 40,
                      //             decoration: BoxDecoration(
                      //               shape: BoxShape.circle,
                      //               border: Border.all(
                      //                 width: 4,
                      //                 color: Theme.of(context)
                      //                     .scaffoldBackgroundColor,
                      //               ),
                      //               color: Colors.blue,
                      //             ),
                      //             child: Icon(
                      //               Icons.edit,
                      //               color: Colors.white,
                      //             ),
                      //           )),
                      //     ],
                      //   ),
                      // ),
                      const SizedBox(
                        height: 35,
                      ),

                      TextField(
                        enabled: false,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(bottom: 3),
                            labelText: "Mobile Number",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: loginMobileNumber,
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      buildTextField("Full Name", name, NameController),
                      buildTextField("E-mail", email, EmailController),
                      //buildTextField("Location", "Gandhinagar, Gujarat"),
                      const SizedBox(
                        height: 35,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 84, 22, 208),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()));
                            },
                            child: const Text("CANCEL",
                                style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 2.2,
                                    color: Colors.white)),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 84, 22, 208),
                            ),
                            onPressed: () async {
                              final db = FirebaseFirestore.instance
                                  .collection("allUser")
                                  .doc(loginMobileNumber)
                                  .set({
                                "name": NameController.text,
                                "email": EmailController.text
                              });
                            },
                            child: const Text(
                              "SAVE",
                              style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 2.2,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }

  Widget buildTextField(
    String labelText,
    String placeholder,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}

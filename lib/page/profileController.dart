import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fts/home.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProfileController with ChangeNotifier {
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('User');

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final picker = ImagePicker();

  XFile? _image;
  XFile? get image => _image;

  Future pickGalleryImage(BuildContext context) async {
    final PickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (PickedFile != null) {
      _image = XFile(PickedFile.path);
      notifyListeners();
    }
  }

  Future pickCameraImage(BuildContext context) async {
    final PickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);

    if (PickedFile != null) {
      _image = XFile(PickedFile.path);
      notifyListeners();
    }
  }

  void pickImage(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 120,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      pickCameraImage(context);
                      Navigator.pop(context);
                    },
                    leading: Icon(
                      Icons.camera,
                      color: Colors.black,
                    ),
                    title: Text('Camera'),
                  ),
                  ListTile(
                    onTap: () {
                      pickGalleryImage(context);
                      Navigator.pop(context);
                    },
                    leading: Icon(
                      Icons.image,
                      color: Colors.black,
                    ),
                    title: Text('Gallery'),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void uploadImage(BuildContext context) {}
} 



  // Future uploadImageToFirebase(File file) async {
  //   firebase_storage.Reference ref =
  //       firebase_storage.FirebaseStorage.instance.ref().child('uploads/');
  //   firebase_storage.UploadTask uploadTask = ref.putFile(file);
  //   firebase_storage.TaskSnapshot taskSnapshot = await uploadTask.onComplete;
  //   taskSnapshot.ref.getDownloadURL().then(
  //         (value) => print("Done: $value"),
  //       );
  // }


// import 'dart:io';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:fts/home.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

// class ProfileController with ChangeNotifier {
//   final auth = FirebaseAuth.instance;

//   firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
//   FirebaseDatabase ref = FirebaseDatabase.instance.ref('allUser') as FirebaseDatabase;

//   final picker = ImagePicker();

//   XFile? _image;
//   XFile? get image => _image;

//   Future pickGalleryImage(BuildContext context) async {
//     final PickedFile =
//         await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

//     if (PickedFile != null) {
//       _image = XFile(PickedFile.path);
//       notifyListeners();
//     }
//   }

//   Future pickCameraImage(BuildContext context) async {
//     final PickedFile =
//         await picker.pickImage(source: ImageSource.camera, imageQuality: 100);

//     if (PickedFile != null) {
//       _image = XFile(PickedFile.path);
//       notifyListeners();
//     }
//   }

//   void pickImage(context) {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             content: Container(
//               height: 120,
//               child: Column(
//                 children: [
//                   ListTile(
//                     onTap: () {
//                       pickCameraImage(context);
//                       Navigator.pop(context);
//                     },
//                     leading: Icon(
//                       Icons.camera,
//                       color: Colors.black,
//                     ),
//                     title: Text('Camera'),
//                   ),
//                   ListTile(
//                     onTap: () {
//                       pickGalleryImage(context);
//                       Navigator.pop(context);
//                     },
//                     leading: Icon(
//                       Icons.image,
//                       color: Colors.black,
//                     ),
//                     title: Text('Gallery'),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }

//   // uploadImage(File file) async {
//   //   firebase_storage.Reference storageRef = firebase_storage.FirebaseStorage.instance.ref('/profileImage' + allUser);
//   //   firebase_storage.UploadTask uploadTask = storageRef.putFile(File(image!.path).absolute);

//   //   await Future.value(uploadTask);
//   //   final newUrl = await storageRef.getDownloadURL();

//   //   ref.child

//   // }
// }
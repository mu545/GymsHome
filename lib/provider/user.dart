//import 'dart:io';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:gymhome/Styles.dart';
import 'package:gymhome/provider/review.dart';
import 'package:image_picker/image_picker.dart';

import '../GymOwnerwidgets/ownerhome.dart';
import '../widgets/newhome.dart';

class User with ChangeNotifier {
  String email = '';
  String name = '';
  final _auth = FirebaseAuth.instance;
  bool iscustomer = false;
  String messages = '';
  User(email, name, bool customer) {
    this.email = email;
    this.name = name;
    this.iscustomer = customer;
  }
  Future signup(bool customer, String email, String name, String password,
      BuildContext cxt) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String userid = FirebaseAuth.instance.currentUser!.uid;
      if (customer) {
        FirebaseFirestore.instance.collection("Customer").doc(userid).set({
          'name': name,
          'profilePicture':
              'https://firebasestorage.googleapis.com/v0/b/gymshome-ce96b.appspot.com/o/DefaultProfilePic.jpg?alt=media&token=e175c7f8-55f2-4575-8315-9bc5a527fd9b'
        });
        Navigator.of(cxt).pushNamed(NewHome.rounamed);
      } else {
        FirebaseFirestore.instance
            .collection("Gym Owner")
            .doc(userid)
            .set({'name': name});
        Navigator.of(cxt).pushNamed(OwnerHome.rounamed);
      }
    } on FirebaseAuthException catch (e) {
      messages = e.code;
      if (e.code == 'weak-password') {
        messages = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        messages = 'The account already exists for that email.';
      }
      message(cxt, false, messages);
    }
    //end catch
  } //end signup

  Future login(String email, String password, BuildContext cxt) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      var collection = FirebaseFirestore.instance.collection('Gym Owner');
      var docSnapshot = await collection.doc(email).get();
      if (docSnapshot.exists) {
        Navigator.of(cxt).pushNamed(OwnerHome.rounamed);
      } else {
        Navigator.of(cxt).pushNamed(NewHome.rounamed);
      }
    } on FirebaseAuthException catch (e) {
      messages = e.code;
      message(cxt, false, messages);
    }
  }

  Future resetpass(String email, BuildContext cxt) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      messages = 'Check your email';
      message(cxt, true, messages);
    } on FirebaseAuthException catch (e) {
      messages = e.code;
      if (messages == 'unknown') messages = 'enter correct email';
      message(cxt, false, messages);
    }
  }

//  static Future<void> logout() async {
//     _token = 'null';
//     _userId = 'null';
//     _expiryDate = 'null' as DateTime;
//     if (_authTimer != 'null') {
//       _authTimer.cancel();
//       _authTimer = 'null' as Timer;
//     }
//     notifyListeners();
//     final prefs = await SharedPreferences.getInstance();
//     // prefs.remove('userData');
//     prefs.clear();
//   }

  static bool areYousure(
      BuildContext cxt, String title, String messame, Function? function) {
    bool sure;

    showDialog<bool>(
      context: cxt,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title, style: TextStyle(color: colors.blue_base)),
        content: Text(messame, style: TextStyle(color: colors.black60)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child:
                const Text('Cancel', style: TextStyle(color: colors.red_base)),
          ),
          TextButton(
            onPressed: () {
              function;
              Navigator.pop(context, true);
            },
            child: const Text(
              'yes',
              style: TextStyle(color: colors.blue_base),
            ),
          ),
        ],
      ),
    ).then((value) {
      return value;
    });
    return false;
  }

  message(BuildContext cxt, bool iserror, String message) {
    ScaffoldMessenger.of(cxt).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
              color: iserror ? colors.green_base : colors.red_base,
              fontFamily: 'Roboto',
              fontSize: 16),
        ),
        backgroundColor: iserror ? colors.green_smooth : colors.red_smooth,
      ),
    );
  }
}

File? _imageFile;

// get image method GALLERY
Future getImageGallery() async {
  final image =
      await ImagePicker.platform.pickImage(source: ImageSource.gallery);
  if (image == null) return;

  final imageTemp = File(image.path);

  _imageFile = imageTemp;
}

// get image method CAMERA
Future getImageCamera() async {
  final image =
      await ImagePicker.platform.pickImage(source: ImageSource.camera);
  if (image == null) return;
  final imageTemp = File(image.path);

  _imageFile = imageTemp;
}

var userEmail = FirebaseAuth.instance.currentUser!.email;
Future uploadPicForUserProfile() async {
  FirebaseStorage storage = FirebaseStorage.instance;
  Reference ref = storage
      .ref()
      .child("$userEmail" + " ProfilePic " + DateTime.now().toString());
  await ref.putFile(_imageFile!);
  String imageurl = await ref.getDownloadURL();
  FirebaseFirestore.instance
      .collection('Customer')
      .doc(userEmail)
      .update({'profilePicture': imageurl});
}

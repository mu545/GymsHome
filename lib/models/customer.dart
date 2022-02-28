//import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gymhome/models/user.dart';
import 'package:ntp/ntp.dart';

class Customer with ChangeNotifier {
  String uid = 'nFEhj3WbiiPsKe3bOuELqQBIl3v2';
  //final String uid = FirebaseAuth.instance.currentUser!.uid;
  String? name;
  String? profilePicture;

  Customer() {
    // uid = '7MZm80HaQqRnaHIZSHBrKpua6p53';
    // uid = FirebaseAuth.instance.currentUser!.uid;
  }
  Customer.named(
      {required this.name, required this.profilePicture, required this.uid});

  Future<void> addRate(String gymid, double rate) async {
    DocumentSnapshot docSnapshot =
        await FirebaseFirestore.instance.collection('Customer').doc(uid).get();

    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      Customer c1 = Customer.fromJson(data, uid);
      DateTime startDate = await NTP.now();
      FirebaseFirestore.instance
          .collection("Gyms")
          .doc(gymid)
          .collection("Review")
          .doc(uid)
          .set({
        'uid': c1.uid,
        'name': c1.name,
        'rate': rate,
        'comment': '',
        'profilePicture': c1.profilePicture,
        'time': startDate
      });
    }
  }

  Future<bool> search(String uid, String gymid) async {
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection("Gyms")
        .doc(gymid)
        .collection("Review")
        .doc(uid)
        .get();
    if (docSnapshot.exists) {
      return true;
    }
    return false;
  }

  // Future editRate(String gymid, double rate) async {
  //   final emailuser = await FirebaseAuth.instance.currentUser?.email;
  //   DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
  //       .collection('Customer')
  //       .doc(emailuser)
  //       .get();
  //   if (docSnapshot.exists) {
  //     Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
  //     Customer c1 = Customer.fromJson(data);
  //     DateTime startDate = await NTP.now();
  //     FirebaseFirestore.instance
  //         .collection('Gyms')
  //         .doc(gymid)
  //         .collection('Review')
  //         .doc(emailuser)
  //         .update({
  //       'name': c1.name,
  //       'rate': rate,
  //       'comment': '',
  //       'profilePicture': c1.profilePicture,
  //       'time': startDate
  //     });
  //   }
  // }

  Future<void> addReviwe(String gymid, double rate, String comment) async {
    DocumentSnapshot docSnapshot =
        await FirebaseFirestore.instance.collection('Customer').doc(uid).get();

    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      Customer c1 = Customer.fromJson(data, uid);
      DateTime startDate = DateTime.now();
      FirebaseFirestore.instance
          .collection("Gyms")
          .doc(gymid)
          .collection("Review")
          .doc(uid)
          .set({
        'uid': c1.uid,
        'name': c1.name,
        'rate': rate,
        'comment': comment,
        'profilePicture': c1.profilePicture,
        'time': startDate
      });
    }
  }

  // Future<Map<String, dynamic>> getData(String uid) async {
  //   Map<String, dynamic> data = {};
  //   DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
  //       .collection('Customer')
  //       .doc(uid)
  //       .get();
  //   if (docSnapshot.exists) {
  //     data = docSnapshot.data() as Map<String, dynamic>;
  //   }
  //   return data;
  // }
  Future<void> deleteReview(String gymid) async {
    FirebaseFirestore.instance
        .collection("Gyms")
        .doc(gymid)
        .collection("Review")
        .doc(uid)
        .delete();
  }

  factory Customer.fromJson(Map<String, dynamic> data, String uid) {
    return Customer.named(
        name: data['name'], profilePicture: data['profilePicture'], uid: uid);
  }
}

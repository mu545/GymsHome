//import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gymhome/models/user.dart';

class Customer with ChangeNotifier {
  //final String email;
  final String name;
  //final File profilePicture;

  Customer({required this.name});

  Future<void> addrate(String gymid, double rate) async {
    // final email = await FirebaseAuth.instance.currentUser?.email;
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection('Customer')
        .doc('R@gmail.com')
        .get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      Customer c1 = Customer.fromJson(data);
      FirebaseFirestore.instance
          .collection("Gyms")
          .doc(gymid)
          .collection("Reviwe")
          .doc('R@gmail.com')
          .set({'name': c1.name, 'rate': rate, 'comment': ''});
    }
  }

  Future<void> addReviwe(String gymid, double rate, String comment) async {
    // final email = await FirebaseAuth.instance.currentUser?.email;
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection('Customer')
        .doc('Fahad.work20@gmail.com')
        .get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      Customer c1 = Customer.fromJson(data);
      FirebaseFirestore.instance
          .collection("Gyms")
          .doc(gymid)
          .collection("Reviwe")
          .doc('Fahad.work20@gmail.com')
          .set({'name': c1.name, 'rate': rate, 'comment': comment});
    }
  }

  Future getData(String email) async {
    // DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
    //     .collection('Customer')
    //     .doc(email)
    //     .get();
    // if (docSnapshot.exists) {
    //  docSnapshot.data() as Map<String, dynamic>;
    // }
    // return null;
  }

  factory Customer.fromJson(Map<String, dynamic> data) {
    return Customer(name: data['name']);
  }
}

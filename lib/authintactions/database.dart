import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:gymhome/models/customer.dart';
//import 'package:path/path.dart';

class DatabaseManager {
  final String uid;
  DatabaseManager({required this.uid});

  final CollectionReference customerCollection =
      FirebaseFirestore.instance.collection("Customer");

  Future updateUserData(String name) async {
    return await customerCollection.doc(uid).set({
      'name': name,
    });
  }

  //customer list from snapshot
  List<Customer> _customerListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Customer(name: doc.get('name') ?? '');
    }).toList();
  }

  // get customers stream. to keep data updated
  Stream<List<Customer>> get customers {
    return customerCollection.snapshots().map(_customerListFromSnapshot);
  }
}

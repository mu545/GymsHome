//import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:gymhome/Styles.dart';

import '../GymOwnerwidgets/ownerhome.dart';
import '../widgets/newhome.dart';

class User {
  String email = '';
  String name = '';
  static final _auth = FirebaseAuth.instance;
  bool iscustomer = false;
  static String messages = '';
  User(email, name, bool customer) {
    this.email = email;
    this.name = name;
    this.iscustomer = customer;
  }
  static Future signup(bool customer, String email, String name,
      String password, BuildContext cxt) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (customer) {
        FirebaseFirestore.instance
            .collection("Customer")
            .doc(email)
            .set({'Name': name});
        Navigator.of(cxt).pushNamed(NewHome.rounamed);
      } else {
        FirebaseFirestore.instance
            .collection("Gym Owner")
            .doc(email)
            .set({'Name': name});
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

  static Future login(String email, String password, BuildContext cxt) async {
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

  static Future resetpass(String email, BuildContext cxt) async {
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

  static void message(BuildContext cxt, bool iserror, String message) {
    ScaffoldMessenger.of(cxt).showSnackBar(
      SnackBar(
        content: Text(
          messages,
          style: TextStyle(
              color: iserror ? colors.green_base : Colors.white,
              fontFamily: 'Roboto',
              fontSize: 16),
        ),
        backgroundColor: iserror ? colors.blue_smooth : colors.red_base,
      ),
    );
  }
}
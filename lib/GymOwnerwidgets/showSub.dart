import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class showSub extends StatefulWidget {
  String uid;
  showSub({Key? key, required this.uid}) : super(key: key);

  @override
  State<showSub> createState() => _showSubState();
}

Map<String, int>? stats = {'': 0};

class _showSubState extends State<showSub> {
  getAll() {
    var snapshot = FirebaseFirestore.instance
        .collection("gyms")
        .where('ownerId', isEqualTo: widget.uid)
        .where('isWaiting', isEqualTo: false)
        .snapshots();
    snapshot.forEach((element) {
      element.docs.forEach((element) {
        setState(() {
          stats!.addAll({element.id: 0});
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: TextButton(
        onPressed: () {
          getAll();
          print(stats!);
        },
        child: Text('CLICK ME'),
      )),
    );
  }
}

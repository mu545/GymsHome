import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymhome/models/GymModel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gymhome/widgets/gymdescrption.dart';

class EditGymInfo extends StatelessWidget {
  EditGymInfo({
    Key? key,
    required this.gymId,
  }) : super(key: key);
  final String gymId;
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  Future? _getData() => _fireStore.collection("gyms").doc(gymId).get();
  GymModel _gymProfile =
      GymModel([], [], 0, 0, 0, 0, 0, '', '', '', '', '', '', false, true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Edit gym'),
        ),
      ),
      body: Column(
        children: [
          StreamBuilder(
              stream: _fireStore.collection("gyms").doc(gymId).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  Map<String, dynamic> _data =
                      snapshot.data.data() as Map<String, dynamic>;
                  _gymProfile = GymModel.fromJson(_data);
                  return Text(
                    '${_gymProfile.name}',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                    ),
                  );
                } else
                  return Text('........');
              }),
          FlatButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('gyms')
                    .doc(gymId)
                    .update({'name': '43'});
              },
              child: Container(
                child: Text('UpdateName'),
              ))
        ],
      ),
    );
  }
}

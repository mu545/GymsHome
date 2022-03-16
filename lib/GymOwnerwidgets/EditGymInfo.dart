import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymhome/models/GymModel.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditGymInfo extends StatelessWidget {
  EditGymInfo({
    Key? key,
  }) : super(key: key);

  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  Future? _getData() => _fireStore.collection("gyms").doc('').get();
  GymModel _gymProfile =
      GymModel([], [], 0, 0, 0, 0, 0, '', '', '', '', '', '', false, true);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getData(),
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
        });
  }
}

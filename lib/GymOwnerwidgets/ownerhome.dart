import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gymhome/GymOwnerwidgets/addgym.dart';
import 'package:gymhome/GymOwnerwidgets/gymOwnerCard.dart';
import 'package:gymhome/models/GymModel.dart';
import 'package:gymhome/models/Gymprofile.dart';
import 'package:gymhome/models/gyms.dart';
import 'package:gymhome/provider/gymsitems.dart';
import 'package:gymhome/widgets/AddGym.dart';
import 'package:gymhome/widgets/edit.dart';
import 'package:gymhome/widgets/gymdescrption.dart';
import 'package:gymhome/widgets/gymgrid.dart';
import 'package:gymhome/widgets/newhome.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:gymhome/Styles.dart';

class OwnerHome extends StatefulWidget with ChangeNotifier {
  static const rounamed = '/shshs';

  @override
  _WidgtessState createState() => _WidgtessState();
}

class _WidgtessState extends State<OwnerHome> {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  List<GymModel> _gymsList = [];

  Future? _getData() => _fireStore
      .collection("Watting")
      .where('ownerId', isEqualTo: 'WR3c9JaDPRSAA7RUHAIgQADmcOW2')
      .where('isWaiting', isEqualTo: false)
      .get();
  // Future? _getDataByID() => _fireStore
  //     .collection("Gyms")
  //     .where("Gym id", isEqualTo: uid)
  //     .orderBy("price", descending: false)
  //     .get();
  // Future<void> addGyms(Gyms gym) async {
  //   FirebaseFirestore.instance.collection("waiting").doc(gymId).update({
  //     'name': gym.title,
  //     'descrption': gym.description,
  //     //  'ImageURL': gym.imageUrl,
  //     //   'price': gym.price,
  //     //  'Location': gym.location,
  //     //   'faciltrs': gym.facilites,
  //   });
  // }

  // var _editedProduct = Gyms(
  //   id: '',
  //   title: '',
  //   price: 0,
  //   description: '',
  //   imageUrl: '',
  //   location: '',
  //   facilites: '',
  // );
  // bool _ShowOnly = false;
  //var gymId = '';
  var uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    final Gym = Provider.of<Gyms>(context);

    final prodactDate = Provider.of<Gymsitems>(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'HOME',
          style: TextStyle(color: Colors.white, fontFamily: 'Epilogue'),
        )),
        backgroundColor: colors.blue_base,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: FutureBuilder(
            future: _getData(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                _gymsList.clear();
                snapshot.data.docs.forEach((element) {
                  _gymsList.add(GymModel.fromJson(element.data()));
                });
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: _gymsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GymCard(
                            gymInfo: _gymsList[index],
                          );
                        },
                      )
                    ],
                  ),
                );
              } else
                return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GymModel _gym = GymModel(
              [], [], 0, 0, 0, 0, 0, '', '', '', '', '', '', false, true);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddGymInfo(
                    gym: _gym,
                    imageFile: null,
                    oldGym: false,
                  )));
        },
        backgroundColor: colors.blue_base,
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gymhome/models/GymModel.dart';
import 'package:gymhome/models/gyms.dart';
import 'package:gymhome/models/user.dart';
import 'package:gymhome/widgets/GymCardCustomer.dart';
import 'package:gymhome/widgets/gymgrid.dart';
import 'package:gymhome/widgets/newhome.dart';
import 'package:provider/provider.dart';

bool _ShowOnly = true;

enum Fillter { Favorit, all }

class Favorite extends StatefulWidget {
  final String userid;
  const Favorite({required this.userid, Key? key}) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

List<dynamic> favs = [];
final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class _FavoriteState extends State<Favorite> {
  _getData() {
    favs.clear();
    return _fireStore
        .collection('gyms')
        .where('Likes', arrayContains: widget.userid)
        .snapshots();
  }

  String priceChoosed = 'non';
  double? price;
  String genderChoosed = 'Men';
  List<GymModel> _gymsList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
              child: Text(
            'Favorite gyms',
            style: TextStyle(color: Colors.black),
          )),
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: StreamBuilder(
          stream: _getData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              _gymsList.clear();
              snapshot.data.docs.forEach((element) {
                _gymsList.add(GymModel.fromJson(element.data()));
              });

              if (_gymsList.isEmpty)
                return Center(
                    child: Container(
                  margin: EdgeInsets.only(top: 100),
                  child: Text(
                    'No gyms found',
                    textAlign: TextAlign.center,
                  ),
                ));

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListView.builder(
                      controller: ScrollController(keepScrollOffset: true),
                      shrinkWrap: true,
                      itemCount: _gymsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GymCardCustomer(
                          price: priceChoosed,
                          gymInfo: _gymsList[index],
                          userid: widget.userid,
                        );
                      },
                    )
                  ],
                ),
              );
            } else
              return Container(
                child: Text(''),
              );
          },
        )));
  }
}

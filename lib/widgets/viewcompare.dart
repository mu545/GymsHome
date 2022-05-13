import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymhome/Styles.dart';
import 'package:gymhome/models/GymModel.dart';
import 'package:gymhome/models/gyms.dart';
import 'package:gymhome/models/user.dart';
import 'package:gymhome/widgets/GymCardCustomer.dart';
import 'package:gymhome/widgets/compareCard.dart';
import 'package:gymhome/widgets/comparegrid.dart';
import 'package:gymhome/widgets/gymgrid.dart';
import 'package:gymhome/widgets/newhome.dart';
import 'package:provider/provider.dart';

import '../provider/customer.dart';

bool _ShowOnly = true;

enum Fillter { Favorit, all }

class Viewcompare extends StatefulWidget {
  final String userid;
  const Viewcompare({required this.userid, Key? key}) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

List<dynamic> compare = [];
final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class _FavoriteState extends State<Viewcompare> {
  _getData() {
    compare.clear();
    return _fireStore
        .collection('gyms')
        .where('compare', arrayContains: widget.userid)
        .snapshots();
  }

  String priceChoosed = 'non';
  double? price;
  // String genderChoosed = 'Men';
  List<GymModel> _gymsList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colors.blue_base,
          title: Center(
              child: Text(
            'Compare gyms',
            style: TextStyle(color: Colors.white),
          )),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              SizedBox(
                width: 5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Text(
                      'Name',
                      style: TextStyle(fontSize: 20, color: colors.blue_base),
                    ),
                  ),
                  Container(
                    child: Icon(
                      Icons.bar_chart,
                      size: 35,
                      color: colors.blue_base,
                    ),
                  ),
                  Container(
                    child: Icon(
                      Icons.directions_walk,
                      size: 35,
                      color: colors.blue_base,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Day',
                        style: TextStyle(fontSize: 20, color: colors.blue_base),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        '1 M',
                        style: TextStyle(fontSize: 20, color: colors.blue_base),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        '3 M',
                        style: TextStyle(fontSize: 20, color: colors.blue_base),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        '6 M',
                        style: TextStyle(fontSize: 20, color: colors.blue_base),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        'Year',
                        style: TextStyle(fontSize: 20, color: colors.blue_base),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: 3,
              ),
              StreamBuilder(
                stream: _getData(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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

                    return Expanded(
                      child: SizedBox(
                        //     width: MediaQuery.of(context).size.width,
                        //   height: 200,
                        child: ListView.builder(
                          controller: ScrollController(keepScrollOffset: true),
                          // shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: _gymsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return compareCard(
                              price: priceChoosed,
                              gymInfo: _gymsList[index],
                              userid: widget.userid,
                            );
                          },
                        ),
                      ),
                    );
                  } else
                    return Container(
                      child: Text(''),
                    );
                },
              ),
            ],
          ),
        ));
  }
}

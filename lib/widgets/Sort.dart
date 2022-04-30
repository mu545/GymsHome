import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:gymhome/Styles.dart';

class Sort extends StatelessWidget {
  final String userid;
  Sort({required this.userid, key}) : super(key: key);
  bool selectedAss = false;
  bool selectedDes = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.blue_base,
        title: Text(
          'Sort Gyms',
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'Epilogue'),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(),
                  height: 30,
                  width: 100,
                  //  color: colors.red_base,
                  decoration: BoxDecoration(color: colors.red_base),
                  child: Center(
                      child: Row(
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      Text('Assending'),
                      Icon(Icons.arrow_upward)
                    ],
                  )),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(),
                  height: 30,
                  width: 100,
                  //  color: colors.red_base,
                  decoration: BoxDecoration(color: colors.red_base),
                  child: Center(
                      child: Row(
                    children: [
                      SizedBox(
                        width: 3,
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text('Desinding'),
                      Icon(Icons.arrow_downward)
                    ],
                  )),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(),
                  height: 30,
                  width: 100,
                  //  color: colors.red_base,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      color: colors.red_base),
                  child: Center(
                      child: Row(
                    children: [
                      SizedBox(
                        width: 3,
                      ),
                      Text('Name'),
                      Icon(Icons.person)
                    ],
                  )),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(),
                  height: 30,
                  width: 100,
                  //  color: colors.red_base,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      color: colors.blue_smooth),
                  child: Center(
                      child: Row(
                    children: [
                      SizedBox(
                        width: 3,
                      ),
                      Text('Price'),
                      Icon(Icons.person)
                    ],
                  )),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(),
                  height: 30,
                  width: 100,
                  //  color: colors.red_base,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      color: colors.red_base),
                  child: Center(
                      child: Row(
                    children: [
                      SizedBox(
                        width: 3,
                      ),
                      Text('Location'),
                      Icon(Icons.person)
                    ],
                  )),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  setDir() {}
}

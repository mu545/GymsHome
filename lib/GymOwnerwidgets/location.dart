import 'dart:io';
import 'package:flutter/material.dart';

import 'package:gymhome/Styles.dart';
import 'package:gymhome/widgets/placeloc.dart';

import '../models/GymModel.dart';
import '../widgets/locationmap.dart';

class Location extends StatefulWidget {
  File? imageFile;
  List<File> newGymImages;
  GymModel gym;
  List<Placelocation> gymsaddress;
  static const routenamed = '/loc';
  Location(
      {Key? key,
      required this.gymsaddress,
      required this.gym,
      required this.imageFile,
      required this.newGymImages})
      : super(key: key);

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            'Select Location',
            style: TextStyle(
              color: Colors.white,
            ),
          )),
          backgroundColor: colors.blue_base,
          elevation: 0,
          actions: <Widget>[
            //   // IconButton(
            //   //   onPressed: () {},
            //   //   icon: Icon(
            //   //     Icons.more_vert,
            //   //     color: Colors.white,
            //   //   ),
            //   // )
          ],
        ),
        body: PlaceLocation(
          gymsaddress: widget.gymsaddress,
          gym: widget.gym,
          imageFile: widget.imageFile,
          newGymImages: widget.newGymImages,
        ));
  }
}

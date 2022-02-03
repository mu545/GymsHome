import 'dart:io';

//import 'package:flutter/cupertino.dart';

class Placelocation {
  String latiitude;
  String longtitude;
  String address;
  Placelocation(this.latiitude, this.longtitude, this.address);
}

class Place {
  final String id;
  final String title;
  //final Placelocation location;
  File imgae;

  Place(this.id, this.title, this.imgae);
}

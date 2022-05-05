import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

//import 'package:flutter/cupertino.dart';

class Placelocation {
  double latiitude;
  double longtitude;
  String address;
  String gymid;
  String gender;
  Placelocation(
      {required this.gender,
      required this.latiitude,
      required this.longtitude,
      required this.address,
      required this.gymid});

  factory Placelocation.getListAddress(Map<String, dynamic> json) {
    GeoPoint location = json['Location'];
    return Placelocation(
        gender: json['gender'],
        latiitude: location.latitude,
        longtitude: location.longitude,
        address: json['name'],
        gymid: json['gymId']);
  }
  static Future<String> calculateDistance(GeoPoint gymLocation) async {
    final Position locdata = await Geolocator.getCurrentPosition();
    GeoPoint userLocation = GeoPoint(locdata.latitude, locdata.longitude);
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((userLocation.latitude - gymLocation.latitude) * p) / 2 +
        cos(gymLocation.latitude * p) *
            cos(userLocation.latitude * p) *
            (1 - cos((userLocation.longitude - gymLocation.longitude) * p)) /
            2;
    String distance = (12742 * asin(sqrt(a))).toStringAsFixed(0) + ' KM';
    return distance;
  }
}

class Place {
  final String id;
  final String title;
  //final Placelocation location;
  File imgae;

  Place(this.id, this.title, this.imgae);
}

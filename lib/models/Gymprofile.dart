import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class GymProfile {
  String? gymOwnerId;
  String? OwnerName;
  String? OwnerImage;
  double? price;
  String? des;
  String? loctaion;
  String? fas;
  bool? favorite;
  List? images;
  bool? isWaiting;

  GymProfile(
      this.gymOwnerId,
      this.OwnerName,
      this.OwnerImage,
      this.price,
      this.des,
      this.loctaion,
      this.fas,
      this.favorite,
      this.images,
      this.isWaiting);

  GymProfile.fromJson(Map<String, dynamic> json) {
    gymOwnerId = json['Gym id'];
    OwnerName = json['name'];
    OwnerImage = json['ImageURL'];
    price = double.parse(json['price'].toString());
    des = json['descrption'];
    loctaion = json['Location'];
    fas = json['faciltrs'];
    favorite = json['isFavorite'];
    isWaiting = json['isWaiting'];
    images = json['images'];
  }
}

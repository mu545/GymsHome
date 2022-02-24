import 'dart:ffi';

class GymProfile {
  late String OwnerName;
  String? OwnerImage;
  double? price;
  String? des;
  String? loctaion;
  String? fas;
  bool? favorite;
  List? images;

  GymProfile(this.OwnerName, this.OwnerImage, this.price, this.des,
      this.loctaion, this.fas, this.favorite, this.images);

  GymProfile.fromJson(Map<String, dynamic> json) {
    OwnerName = json['name'];
    OwnerImage = json['ImageURL'];
    price = json['price'];
    des = json['descrption'];
    loctaion = json['Location'];
    fas = json['faciltrs'];
    favorite = json['isFavorite'];
    images = json['images'];
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentModel {
  String? customerId;
  Timestamp? date;
  Timestamp? expirationDate;
  String? duration;
  String? gymId;
  double? price;
  String? ownerId;
  String? gymName;

  PaymentModel(this.customerId, this.date, this.duration, this.gymId,
      this.expirationDate, this.price, this.gymName, this.ownerId);

  PaymentModel.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    gymId = json['gymId'];
    ownerId = json['ownerId'];
    gymName = json['gymName'];
    duration = json['duration'];
    price = double.parse(json['price'].toString());
    expirationDate = json['expirationDate'];
    date = json['date'];
  }
}

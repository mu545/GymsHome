//import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Customer with ChangeNotifier {
  //final String email;
  final String name;
  //final File profilePicture;

  Customer({required this.name});

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _customerFromJson(json);

  Map<String, dynamic> toJson() => _nameFromJson(this);

  String toString() => "Customer<$Customer>";

  // Customer(
  //   {required this.email, required this.name, required this.profilePicture});
}

Customer _customerFromJson(Map<String, dynamic> json) {
  return Customer(
    name: json['name'] as String,
  );
}

// 2
Map<String, dynamic> _nameFromJson(Customer instance) => <String, dynamic>{
      'name': instance.name,
    };

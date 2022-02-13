import 'dart:html';
//import 'dart:io';
import 'package:flutter/material.dart';

class Customer with ChangeNotifier {
  final String email;
  final String name;
  final File profilePicture;

  Customer(
      {required this.email, required this.name, required this.profilePicture});
}

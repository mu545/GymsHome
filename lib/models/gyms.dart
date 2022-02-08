import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Gyms with ChangeNotifier  {
 final String id;
  final String title;
  final String description;
   double price;
  final String imageUrl;
  final String location ;
  final String facilites ;
  final double offer ;

  final String hours;
     bool isFavorite;
     bool iscompared;
       bool isadd;

  


  Gyms({  required this.id,required this.title, required this.description,required this.price,required this.imageUrl,required this.location, required this.facilites, required  this.offer ,required this.hours,   this.isFavorite = false, this.iscompared =false , this.isadd=false});
  
  Map<String, Gyms> _items = {};
  Map<String, Gyms> get items {
    return {..._items};
  }
   Future<void> FavoiritStatus() async {
    final oldstates = isFavorite;
    // isFavorite = !isFavorite;
    // notifyListeners();
    final url = 'https://gymshome-ce96b-default-rtdb.firebaseio.com/gyms.json';
    try {
      await http.patch(
        Uri.parse(url),
        body: json.encode({'isFavorite': isFavorite}),
      );
    } catch (error) {
      isFavorite = oldstates;
    }

    isFavorite = !isFavorite;
    notifyListeners();
  }
  Future<void> CompareStatus() async {
    final oldstates = iscompared;
    // isFavorite = !isFavorite;
    // notifyListeners();
    final url = 'https://gymshome-ce96b-default-rtdb.firebaseio.com/gyms.json';
    try {
      await http.patch(
        Uri.parse(url),
        body: json.encode({'iscompared': iscompared}),
      );
    } catch (error) {
      iscompared = oldstates;
    }

    iscompared = !iscompared;
    notifyListeners();
  }
  //  void CompareStatus() {
  //   final oldstates = iscompared;
  //   iscompared = !iscompared;
  //   notifyListeners();
  //   // final url = 'https://shop-app-664ca-default-rtdb.firebaseio.com/prod.json';
  //   // try {
  //   //   await http.patch(
  //   //     Uri.parse(url),
  //   //     body: json.encode({'isFavorite': isFavorite}),
  //   //   );
  //   // } catch (error) {
  //   //   isFavorite = oldstates;
  //   // }

  //   // isFavorite = !isFavorite;
  //   // notifyListeners();
  // }
  // Future <void > poolstatus() async {
  //   final oldstates = pool;
  //   pool = !pool;
  //   notifyListeners();
  //   final url = 'https://gymshome-ce96b-default-rtdb.firebaseio.com/gyms.json';
  //   try {
  //     await http.patch(
  //       Uri.parse(url),
  //       body: json.encode({'pool': pool}),
  //     );
  //   } catch (error) {
  //     pool = oldstates;
  //   }

  //   pool = !pool;
  //   notifyListeners();
  // }

  void favoriteproducts() {
    final oldstates = isadd;
    isadd = !isadd;

    notifyListeners();
  }
   void additem(String productId, String title, double price, double offer , String image) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (exe) => Gyms(
              id: exe.id,
              title: exe.title,
              description:exe.description ,
              price: exe.price,
              imageUrl: exe.imageUrl, 
              location: exe.location, 
              facilites: exe.facilites ,
              offer: exe.offer, 
              hours: exe.hours));
    } else {
      _items.putIfAbsent(
          productId,
          () => Gyms(
              id: DateTime.now().toString(),
              title: title,
              description: description,
              price: price,
             offer: offer,
              imageUrl: imageUrl , location: location , facilites: facilites , hours: hours));
    }
    notifyListeners();
  }

}
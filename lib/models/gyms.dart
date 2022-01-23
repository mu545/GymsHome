import 'package:flutter/material.dart';

class Gyms with ChangeNotifier  {
 final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
     bool isFavorite;
       bool isadd;

  


  Gyms({  required this.id,required this.title, required this.description,required this.price,required this.imageUrl,  this.isFavorite = false,  this.isadd=false});
  
  Map<String, Gyms> _items = {};
  Map<String, Gyms> get items {
    return {..._items};
  }
   void FavoiritStatus() {
    final oldstates = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    // final url = 'https://shop-app-664ca-default-rtdb.firebaseio.com/prod.json';
    // try {
    //   await http.patch(
    //     Uri.parse(url),
    //     body: json.encode({'isFavorite': isFavorite}),
    //   );
    // } catch (error) {
    //   isFavorite = oldstates;
    // }

    // isFavorite = !isFavorite;
    // notifyListeners();
  }

  void favoriteproducts() {
    final oldstates = isadd;
    isadd = !isadd;

    notifyListeners();
  }
   void additem(String productId, String title, double price, String image) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (exe) => Gyms(
              id: exe.id,
              title: exe.title,
              description:exe.description ,
              price: exe.price,
              imageUrl: exe.imageUrl));
    } else {
      _items.putIfAbsent(
          productId,
          () => Gyms(
              id: DateTime.now().toString(),
              title: title,
              description: description,
              price: price,
             
              imageUrl: imageUrl));
    }
    notifyListeners();
  }

}
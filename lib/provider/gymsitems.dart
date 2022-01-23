import 'package:flutter/material.dart';
import 'package:gymhome/models/gyms.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';

// import 'package:onlinestore_example/Models/httpexe.dart';

class Gymsitems with ChangeNotifier {
  List<Gyms> _items = [
    Gyms(   id: 'p1',
        title: 'Fitness Time',
        description:
            ' ',
        price: 200,
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYdK-lU-JxF6Czh43PSD8kF6LlF0ge9c4jxQ&usqp=CAU',
            isFavorite: false ,
    ),
     Gyms(   id: 'p2',
        title: 'Fitness Time',
        description:
            ' ',
        price: 200,
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYdK-lU-JxF6Czh43PSD8kF6LlF0ge9c4jxQ&usqp=CAU',
            isFavorite: false ,
    )
  ];

  List<Gyms> get items {
    return [..._items];
  }

   Gyms FindbyId(String id) {
    print(id + 'p1');
    return _items.firstWhere((gym) => gym.id == id);
  }

  List<Gyms> get favoriteitem {
    return _items.where((element) => element.isFavorite).toList();
  }
List<Gyms> get favoriteproduct {
    return _items.where((element) => element.isadd).toList();
  }
  // Product FindbyId(String id) {
  //   print(id + 'Muhammed');
  //   return _items.firstWhere((proud) => proud.id == id);
  // }

  // List<Product> get favoriteitem {
  //   return _items.where((element) => element.isFavorite).toList();
  // }

  // List<Product> get favoriteproduct {
  //   return _items.where((element) => element.isadd).toList();
  // }

//   Future<void> Fetch() async {
//     const url =
//         'https://newchatapp-c5f1d-default-rtdb.firebaseio.com/prod.json';
//
//     final List<Product> Loadeproducts = [];
//
//     Loadeproducts.add(Product(
//       id: '',
//       imageUrl: '',
//       description: '',
//       isFavorite: true,
//       price: 10,
//       title: '',
//     ));
//
//     _items = Loadeproducts;
//     notifyListeners();
//   }
// }

//
// //   void remove(String id) async {
// //     final url = 'https://newchatapp-c5f1d-default-rtdb.firebaseio.com/prod/$id';
// //     final existindpro = _items.indexWhere((element) => element.id == id);
// //     var existproduct = _items[existindpro];
// //     _items.removeAt(existindpro);
// //     notifyListeners();
// //     final response = await http.delete(Uri.parse(url));
// //
// //     if (response.statusCode >= 400) {
// //       _items.insert(existindpro, existproduct);
// //       notifyListeners();
// //       throw httpexeption('could not delet product.');
// //     }
// //     existproduct == null;
// //   }
// //
  // void Update(String id, Product newpro) {
  //   final proind = _items.indexWhere((prod) => prod.id == id);
  //   final url =
  //       'https://newchatapp-c5f1d-default-rtdb.firebaseio.com/prod//$id';
  //   http.patch(Uri.parse(url),
  //       body: json.encode({
  //         'title': newpro.title,
  //         'descreption': newpro.description,
  //         'Imageurl': newpro.imageUrl,
  //         'price': newpro.price
  //       }));
  //   if (proind >= 0) {
  //     _items[proind] = newpro;
  //     notifyListeners();
  //   } else {
  //     print('');
  //   }
  // }

  // void addpro(Product product) {
  //   const url =
  //       'https://newchatapp-c5f1d-default-rtdb.firebaseio.com/products.json';

  //   http.post(
  //     Uri.parse(url),
  //     body: json.encode(
  //       {
  //         'title': product.title,
  //         'descrption': product.description,
  //         'ImageURL': product.imageUrl,
  //         'price': product.price,
  //         'isFavorite': product.isFavorite
  //       },
  //     ),
  //   );
  //   final newpro = Product(
  //       id: DateTime.now().toString(),
  //       title: product.title,
  //       description: product.description,
  //       price: product.price,
  //       imageUrl: product.imageUrl,
  //       rating: product.rating);
  //   _items.add(newpro);
  //   notifyListeners();
  // }
}

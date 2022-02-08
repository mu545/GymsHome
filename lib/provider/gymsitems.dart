import 'package:flutter/material.dart';
import 'package:gymhome/models/gyms.dart';

import 'package:http/http.dart' as http;
import '../authintactions/httpexe.dart';
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
            location: '' , 
            facilites: '' ,
            offer: 0,
            hours: '' 
    ),
    //  Gyms(   id: 'p2',
    //     title: 'Fitness Time',
    //     description:
    //         ' ',
    //     price: 200,
    //     imageUrl:
    //         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYdK-lU-JxF6Czh43PSD8kF6LlF0ge9c4jxQ&usqp=CAU',
    //         isFavorite: false ,
    //             location: '' , 
    //         facilites: '' ,
    //         hours: '' 
    // ),
    //  Gyms(   id: 'p2',
    //     title: 'Fitness Time',
    //     description:
    //         ' ',
    //     price: 200,
    //     imageUrl:
    //         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYdK-lU-JxF6Czh43PSD8kF6LlF0ge9c4jxQ&usqp=CAU',
    //         isFavorite: false ,
    //             location: '' , 
    //         facilites: '' ,
    //         hours: '' 
    // )
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
   List<Gyms> get compareitems {
    return _items.where((element) => element.iscompared).toList();
  }
List<Gyms> get favoriteproduct {
    return _items.where((element) => element.isadd).toList();
  }Future<void> Fetch() async {
    const url =
        'https://gymshome-ce96b-default-rtdb.firebaseio.com/gyms.json';

    final List<Gyms> Loadeproducts = [];

    Loadeproducts.add(Gyms(
      id: '',
      imageUrl: '',
      description: '',
      isFavorite: true,
      price: 10,
      title: '',
      location: '' , 
      facilites: '' , 
      offer: 0,
      hours: '' ,
    ));

    _items = Loadeproducts;
    notifyListeners();
  }
   void remove(String id) async {
    final url = 'https://gymshome-ce96b-default-rtdb.firebaseio.com/gym/$id';
    final existindpro = _items.indexWhere((element) => element.id == id);
    var existproduct = _items[existindpro];
    _items.removeAt(existindpro);
    notifyListeners();
    final response = await http.delete(Uri.parse(url));

    if (response.statusCode >= 400) {
      _items.insert(existindpro, existproduct);
      notifyListeners();
      throw HttpException('could not delet gym.');
    }
    existproduct == null;
  }
   void Update(String id, Gyms newpro) {
    final proind = _items.indexWhere((prod) => prod.id == id);
    final url =
        'https://gymshome-ce96b-default-rtdb.firebaseio.com/gym/$id';
    http.patch(Uri.parse(url),
        body: json.encode({
          'title': newpro.title,
          'descreption': newpro.description,
          'Imageurl': newpro.imageUrl,
          'price': newpro.price
        }));
    if (proind >= 0) {
      _items[proind] = newpro;
      notifyListeners();
    } else {
      print('');
    }
  }
    Future<void> fetchAndSetProducts() async {
    // final filterString = filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url =
        'https://gymshome-ce96b-default-rtdb.firebaseio.com/gyms.json';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      // url =
      //     'https://fluttershop-app.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
      final favoriteResponse = await http.get(Uri.parse(url));
      final favoriteData = json.decode(favoriteResponse.body);
      final List<Gyms> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Gyms(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          isFavorite:
              favoriteData == null ? false : favoriteData[prodId] ?? false,
          imageUrl: prodData['imageUrl'],
          location: prodData['location'],
          facilites: prodData['facil'],
          offer: prodData['offer'],
          hours: prodData['hour'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
//   Future <void>addpro(Gyms product ) async {
//     const url =
//         'https://gymshome-ce96b-default-rtdb.firebaseio.com/gyms.json' ;
//  try {
//       final responce = http.post(
//       Uri.parse(url),
//       body: json.encode(
//         {
//           'title': product.title,
//           'descrption': product.description,
//           'ImageURL': product.imageUrl,
//           'price': product.price,
//           'isFavorite': product.isFavorite,
//           'Location' : product.location, 
//           'faciltrs' : product.facilites , 
//           'hpurs' : product.hours
//         },)
//       );
//      final newpro = Gyms(
//         id:json.decode(responce.)['name'],
//         title: product.title,
//         description: product.description,
//         price: product.price,
//         imageUrl: product.imageUrl,
//         location: product.location , 
//         facilites: product.facilites , 
//         hours: product.hours
//         );  _items.add(newpro);
//     notifyListeners();
   
//      } catch (error) {
//       throw error;
//     }
//       // print(json.decode(response.body));
    
//   }
  Future<void> addProduct(Gyms product) async {
    final url = 'https://gymshome-ce96b-default-rtdb.firebaseio.com/gyms.json';
    
    try {
      final response = await http.post(
        Uri.parse(url ), body: json.encode({
            'title': product.title,
          'descrption': product.description,
          'ImageURL': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
          'Location' : product.location, 
          'faciltrs' : product.facilites , 
         
          'hpurs' : product.hours
        }),
      );

      final newProduct = Gyms(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
          location: product.location , 
        facilites: product.facilites , 
        offer: product.offer,
     

        hours: product.hours, 
      );

      _items.add(newProduct);
      notifyListeners();

    } catch (error) {
      throw error;
    }
      // print(json.decode(response.body));
    
  }
    
}


 




 
 

  

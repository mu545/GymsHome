import 'package:firebase_auth/firebase_auth.dart';
import 'package:gymhome/models/GymModel.dart';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'dart:io';
import '../models/gyms.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddGymMethods with ChangeNotifier {
  String? gymId;
  String? userId;
  // GymProfile _gymProfile =
  //     GymProfile('', '', '', 0, '', '', '', false, [], true);

  Future updateNameAndDes(Gyms gym) async {
    FirebaseFirestore.instance.collection("gyms").doc(gymId).update({
      'name': gym.title,
      'descrption': gym.description,
    });
  }

  Future uploadFacilities(List facilities) async {
    FirebaseFirestore.instance.collection("gyms").doc(gymId).update({
      'faciltrs': facilities,
    });
  }

  // var userId = FirebaseAuth.instance.currentUser?.uid;
  Future<String?> getuid() async {
    var _userdata = await SharedPreferences.getInstance();

    return _userdata.getString('uid');
  }

  // var userId = SharedPreferences.getInstance();

  final FirebaseFirestore _1fireStore = FirebaseFirestore.instance;
  Future getGymData() async => _1fireStore.collection('gyms').doc(gymId).get();

// get image method GALLERY
  Future getImageGallery(File? _imageFile, String gymId) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref =
        storage.ref().child(gymId + " MainGymPic " + DateTime.now().toString());
    await ref.putFile(_imageFile!);
    String imageurl = await ref.getDownloadURL();
    FirebaseFirestore.instance
        .collection('gyms')
        .doc(gymId)
        .update({'imageURL': imageurl});
  }

  Future uploadFiles(arrayImage, gymId) async {
    for (var img in arrayImage) {
      FirebaseStorage storage = FirebaseStorage.instance;

      Reference ref = storage.ref().child('images/${Path.basename(img.path)}');
      await ref.putFile(img).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          FirebaseFirestore.instance.collection('gyms').doc(gymId).update({
            'images': FieldValue.arrayUnion([value])
          });
        });
      });
    }
  }

  Future addPrices(oneD, oneM, threeM, sixM, oneY) async {
    FirebaseFirestore.instance.collection("gyms").doc(gymId).update({
      'One Day': oneD,
      'One Month': oneM,
      'Three Months': threeM,
      'Six Months': sixM,
      'One Year': oneY,
    });
  }

  // Future getDoc(String? id) async {
  //   var a =
  //       await FirebaseFirestore.instance.collection('Watting').doc(id).get();
  //   if (a.exists) {
  //     print('Exists');
  //     return 'Exists';
  //   } else {
  //     print('Not exists');
  //     return 'Not exists';
  //   }
  // }

  // Future<bool> search(String gymid) async {
  //   DocumentSnapshot docSnapshot =
  //       await FirebaseFirestore.instance.collection("gyms").doc(gymid).get();
  //   if (docSnapshot.exists) {
  //     return true;
  //   }
  //   return false;
  // }
  // Future addLocation(String gymId, GeoPoint location) async {
  //   FirebaseFirestore.instance.collection("gyms").doc(gymId).update({
  //     'Location': location

  //   });
  // }

  Future addGym(
      GymModel newGym, File? imageUrl, List<File> newGymImages, prices) async {
    if (newGym.gymId!.isNotEmpty) {
      var gym = FirebaseFirestore.instance.collection('gyms').doc(newGym.gymId);
      gym.update({
        'prices': prices,
        'Location': newGym.location,
        'descrption': newGym.description,
        'faciltrs': newGym.faciltrs,
        'name': newGym.name,
        'One Day': newGym.priceOneDay,
        'One Month': newGym.priceOneMonth,
        'Three Months': newGym.priceThreeMonths,
        'Six Months': newGym.priceSixMonths,
        'One Year': newGym.priceOneYear,
        'isWaiting': false,
        'isComplete': false,
        'gender': newGym.gender,
      });
      if (imageUrl != null) getImageGallery(imageUrl, gym.id);
    } else {
      var gym = FirebaseFirestore.instance.collection('gyms').doc();
      getuid().then((value) => {
            gym.set({
              'prices': prices,
              'gymId': gym.id,
              'ownerId': value,
              'images': [],
              'Likes': [],
              'compare': [],
              'imageURL': 'newGym.imageURL',
              'Location': newGym.location,
              'descrption': newGym.description,
              'faciltrs': newGym.faciltrs,
              'name': newGym.name,
              'One Day': newGym.priceOneDay,
              'One Month': newGym.priceOneMonth,
              'Three Months': newGym.priceThreeMonths,
              'Six Months': newGym.priceSixMonths,
              'One Year': newGym.priceOneYear,
              'isWaiting': true,
              'isComplete': false,
              'gender': newGym.gender,
              'Avg_rate': newGym.avg_rate,
              'reviews': newGym.reviews,
            }).whenComplete(() => getImageGallery(imageUrl, gym.id)
                .whenComplete(() => uploadFiles(newGymImages, gym.id))),
            getImageGallery(imageUrl, gym.id)
          });
    }
  }
}

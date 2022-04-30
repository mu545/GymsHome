import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gymhome/models/GymModel.dart';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gymhome/models/Gymprofile.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../models/gyms.dart';

class AddGymMethods with ChangeNotifier {
  String? gymId;
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

  var userId = FirebaseAuth.instance.currentUser?.uid;

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

  Future addGym(
      GymModel newGym, File? imageUrl, List<File> newGymImages) async {
    if (newGym.gymId!.isNotEmpty) {
      var gym = FirebaseFirestore.instance.collection('gyms').doc(newGym.gymId);
      gym.update({
        'Location': '7KM',
        'descrption': newGym.description,
        'faciltrs': newGym.faciltrs,
        'name': newGym.name,
        'One Day': newGym.priceOndDay,
        'One Month': newGym.priceOndMonth,
        'Three Months': newGym.priceThreeMonts,
        'Six Months': newGym.priceSixMonths,
        'One Year': newGym.priceOneYear,
        'isWaiting': false,
        'isComplete': false,
        'gender': newGym.gender,
      });
      if (imageUrl != null) getImageGallery(imageUrl, gym.id);
    } else {
      var gym = FirebaseFirestore.instance.collection('gyms').doc();
      gym.set({
        'gymId': gym.id,
        'ownerId': userId,
        'images': [],
        'imageURL': 'newGym.imageURL',
        'Location': '7KM',
        'descrption': newGym.description,
        'faciltrs': newGym.faciltrs,
        'name': newGym.name,
        'One Day': newGym.priceOndDay,
        'One Month': newGym.priceOndMonth,
        'Three Months': newGym.priceThreeMonts,
        'Six Months': newGym.priceSixMonths,
        'One Year': newGym.priceOneYear,
        'isWaiting': true,
        'isComplete': false,
        'gender': newGym.gender
      }).whenComplete(() => getImageGallery(imageUrl, gym.id)
          .whenComplete(() => uploadFiles(newGymImages, gym.id)));
      getImageGallery(imageUrl, gym.id);
    }
  }
}

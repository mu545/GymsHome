import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';
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

  var userId = FirebaseAuth.instance.currentUser!.uid;

  final FirebaseFirestore _1fireStore = FirebaseFirestore.instance;
  Future getGymData() async => _1fireStore.collection('gyms').doc(gymId).get();

// get image method GALLERY
  Future getImageGallery(File? _imageFile) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage
        .ref()
        .child("$gymId" + " MainGymPic " + DateTime.now().toString());
    await ref.putFile(_imageFile!);
    String imageurl = await ref.getDownloadURL();
    FirebaseFirestore.instance
        .collection('gyms')
        .doc(gymId)
        .update({'imageURL': imageurl});
  }

  Future uploadFiles(arrayImage) async {
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

  Future addGym() async {
    var gym = FirebaseFirestore.instance.collection('gyms').doc();
    gym.set({
      'gymId': 'gymId',
      'ownerId': userId,
      'images': [],
      'imageURL':
          'https://firebasestorage.googleapis.com/v0/b/gymshome-ce96b.appspot.com/o/4hUQVJyfW6X2BeiXwBNI%20MainGymPic%202022-02-26%2004%3A13%3A38.678156?alt=media&token=fe183255-3fae-4412-aacc-6b420d846d19',
      'Location': '7KM',
      'descrption': 'gym.description',
      'faciltrs': [],
      'name': 'gym.title',
      'isFavorite': false,
      'One Day': 0,
      'One Month': 0,
      'Three Months': 0,
      'Six Months': 0,
      'One Year': 0,
      'isWaiting': true,
      'isComplete': false,
    }).whenComplete(() {
      gymId = gym.id;
      FirebaseFirestore.instance
          .collection('gyms')
          .doc(gymId)
          .update({'gymId': gymId});
    });
  }
}

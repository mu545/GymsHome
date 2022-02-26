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
  GymProfile _gymProfile =
      GymProfile('', '', '', 0, '', '', '', false, [], true);

  Future updateNameAndDes(Gyms gym) async {
    FirebaseFirestore.instance.collection("Gyms").doc(gymId).update({
      'name': gym.title,
      'descrption': gym.description,
    });
  }

  var userId = FirebaseAuth.instance.currentUser!.uid;

  final FirebaseFirestore _1fireStore = FirebaseFirestore.instance;
  Future getGymData() async => _1fireStore.collection('Gyms').doc(gymId).get();

  File? _imageFile;

// get image method GALLERY
  Future getImageGallery() async {
    final image =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imageTemp = File(image.path);

    _imageFile = imageTemp;
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage
        .ref()
        .child("$gymId" + " MainGymPic " + DateTime.now().toString());
    await ref.putFile(_imageFile!);
    String imageurl = await ref.getDownloadURL();
    FirebaseFirestore.instance
        .collection('Gyms')
        .doc(gymId)
        .update({'ImageURL': imageurl});
  }

  Future uploadFiles(arrayImage) async {
    for (var img in arrayImage) {
      FirebaseStorage storage = FirebaseStorage.instance;

      Reference ref = storage.ref().child('images/${Path.basename(img.path)}');
      await ref.putFile(img).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          FirebaseFirestore.instance.collection('Gyms').doc(gymId).update({
            'images': FieldValue.arrayUnion([value])
          });
        });
      });
    }
  }

  Future addGym() async {
    var gym = FirebaseFirestore.instance.collection('Gyms').doc();
    gym.set({
      'Gym id': userId,
      'images': [],
      'ImageURL': 'NO PIC',
      'Location': 'gym.location',
      'descrption': 'gym.description',
      'faciltrs': 'gym.facilites',
      'name': 'gym.title',
      'isFavorite': false,
      'price': 'gym.price',
      'isWaiting': true,
    }).whenComplete(() => gymId = gym.id);
  }
}

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymhome/Styles.dart';
import 'package:gymhome/models/GymModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ManageNewGymImages extends StatefulWidget {
  List<dynamic>? images;

  ManageNewGymImages({Key? key, required this.images}) : super(key: key);

  @override
  State<ManageNewGymImages> createState() => _ManageNewGymImagesState();
}

class _ManageNewGymImagesState extends State<ManageNewGymImages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PhotoViewGallery.builder(
            itemCount: widget.images!.length,
            builder: (context, index) {
              final urlImage = widget.images![index];

              return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(urlImage));
            }));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymhome/Styles.dart';
import 'package:gymhome/models/GymModel.dart';
import 'package:gymhome/widgets/imageinput.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:gymhome/widgets/AddGym.dart';
import '../models/Gymprofile.dart';
import 'add_image.dart';

class ViewGymImages extends StatefulWidget {
  @override
  _ViewGymImagesState createState() => _ViewGymImagesState();
}

class _ViewGymImagesState extends State<ViewGymImages> {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final String userId = "95fFRxumpsU3TI6jXi1K";
  GymModel _gymProfile = GymModel(
      [], [], [], 0, 0, 0, 0, 0, '', '', '', '', '', '', false, true, '', 0);

  Future? _getData() => _fireStore.collection('Gyms').doc(userId).get();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Uploaded Pictures'),
            backgroundColor: colors.blue_base),
        floatingActionButton: FloatingActionButton(
          backgroundColor: colors.blue_base,
          child: Icon(Icons.add, color: Colors.white),
          onPressed: () {
            //   Navigator.of(context)
            //       .push(MaterialPageRoute(builder: (context) => AddImage()));
          },
        ),
        body: FutureBuilder(
          future: _getData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              Map<String, dynamic> _data =
                  snapshot.data.data() as Map<String, dynamic>;
              _gymProfile = GymModel.fromJson(_data);
              if (_gymProfile.images!.isEmpty) {
                return Center(
                  child: Text(
                    'There are no images uploaded yet, try adding some images of your gym and its facilities by clicking the add button below',
                    textAlign: TextAlign.center,
                  ),
                );
              }
              return Container(
                child: GridView.builder(
                    itemCount: _gymProfile.images!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(3),
                        child: FadeInImage.memoryNetwork(
                          fit: BoxFit.cover,
                          placeholder: kTransparentImage,
                          image: _gymProfile.images![index],
                          // return !snapshot.hasData
                          //     ? Center(
                          //         child: CircularProgressIndicator(),
                          //       )
                          //     : Container(
                          //         child: GridView.builder(
                          //             itemCount: snapshot.data,
                          //             gridDelegate:
                          //                 SliverGridDelegateWithFixedCrossAxisCount(
                          //                     crossAxisCount: 3),
                          //             itemBuilder: (context, index) {
                          //               return Container(
                          //                 margin: EdgeInsets.all(3),
                          //                 child: FadeInImage.memoryNetwork(
                          //                   fit: BoxFit.cover,
                          //                   placeholder: kTransparentImage,
                          //                   image: snapshot.data![index]
                          //                       .get('url'),
                        ),
                      );
                    }),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}

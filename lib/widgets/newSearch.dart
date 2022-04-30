import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:search_page/search_page.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gymhome/models/GymModel.dart';
import 'package:gymhome/models/user.dart';
import 'package:gymhome/widgets/gymdescrption.dart';

// class newSearch extends StatefulWidget {
//   const newSearch({Key? key}) : super(key: key);
//   @override
//   State<newSearch> createState() => _newSearch();
// }

class newSearch extends SearchDelegate {
  CollectionReference _firebaseFirestore =
      FirebaseFirestore.instance.collection('gyms');

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        color: Colors.red,
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  // newSearch() {}
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firebaseFirestore.snapshots().asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.data!.docs
                .where((QueryDocumentSnapshot<Object?> element) =>
                    element['name']
                        .toString()
                        .toLowerCase()
                        .contains(query.toLowerCase()))
                .isEmpty) {
              return Center(
                child: Text('No Search query found'),
              );
            } else {
              return ListView(children: [
                ...snapshot.data!.docs
                    .where((QueryDocumentSnapshot<Object?> element) =>
                        element['name']
                            .toString()
                            .toLowerCase()
                            .contains(query.toLowerCase()))
                    .map((QueryDocumentSnapshot<Object?> data) {
                  // final g
                  final String name = data['name'];
                  final String gymIcon = data['imageURL'];
                  GymModel fetchGym = GymModel.fromQ(data);

                  // datas = dsajej(data)
                  // final String gymIcon = data['imageURL'];
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => GymDescrption(
                                gym: fetchGym,
                                userid: userId,
                              )));
                    },
                    title: Text(name),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(gymIcon),
                    ),
                  );
                })
              ]);
            }
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(child: Text('Search anything here'));
  }

  // @override
  // List<Widget> buildActions(BuildContext context) {
  //   // TODO: implement buildActions
  //   List<Widget> low = [];
  //   return low;
  // }
}

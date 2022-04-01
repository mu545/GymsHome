import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gymhome/Styles.dart';
import 'package:gymhome/models/customer.dart';
import 'package:gymhome/models/user.dart';
import 'package:intl/intl.dart';

//hla milfy
class Review {
  String uid;
  String name;
  String profileimg;
  double rate;
  String comment;
  String time;

  Review(
      {required this.uid,
      required this.name,
      required this.profileimg,
      required this.rate,
      required this.comment,
      required this.time});
  static Review fromList(QueryDocumentSnapshot<Object?> data) {
    String time = getTime(data.get('time'));
    return Review(
        uid: data.get('uid'),
        name: data.get('name'),
        profileimg: data.get('profilePicture'),
        rate: data.get('rate').toDouble(),
        comment: data.get('comment'),
        time: time);
  }

  static String getTime(Timestamp timestamp) {
    String time;
    int year = timestamp.toDate().year;
    int month = timestamp.toDate().month;
    int day = timestamp.toDate().day;
    time = DateFormat.yMMMMd().format(DateTime(year, month, day));
    return time;
  }

  @override
  static Future<Review?> getUserreview(String gymid, String uid) async {
    Review userrevew = Review(
        uid: '', name: '', profileimg: '', rate: 0.0, comment: '', time: '');
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('Gyms')
        .doc(gymid)
        .collection('Review')
        .doc(uid)
        .get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      return userrevew = Review.fromjson(data);
    }
    return null;
  }

  static getcomments(String gymid) {
    return FirebaseFirestore.instance
        .collection('Gyms')
        .doc(gymid)
        .collection('Review')
        .orderBy('time', descending: true)
        .snapshots();
  }

  Future<bool> search(String uid, String gymid) async {
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection("Gyms")
        .doc(gymid)
        .collection("Review")
        .doc(uid)
        .get();
    if (docSnapshot.exists) {
      return true;
    }
    return false;
  }

  static void show(BuildContext cxt, Review? userReview, String gymid) {
    double rate = 0.0;
    String comment = '';
    final GlobalKey<FormState> _formKey = GlobalKey();
    if (userReview != null) {
      rate = userReview.rate;
      comment = userReview.comment;
    } else {
      rate = 0.0;
      comment = '';
    }
    final Map<String, dynamic> _reviwe = {'reviews': comment, 'rate': rate};
    showDialog(
        context: cxt,
        builder: (BuildContext cxt) {
          return Center(
            child: SingleChildScrollView(
              child: AlertDialog(
                content: Container(
                  width: MediaQuery.of(cxt).size.width,
                  child: Column(children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Write a review",
                                style: TextStyle(
                                    fontFamily: 'Epilogue',
                                    fontSize: 18,
                                    color: colors.blue_base),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(cxt).pop();
                                },
                                child: Icon(
                                  Icons.cancel_outlined,
                                  color: colors.iconscolor,
                                  size: 25,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RatingBar.builder(
                            initialRating: _reviwe['rate'],
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              size: 6,
                              color: colors.yellow_base,
                            ),
                            onRatingUpdate: (rating) {
                              _reviwe['rate'] = rating;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                                initialValue: _reviwe['reviews'],
                                maxLines: null,
                                obscureText: false,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  hintText: "review (optional)",
                                  hintStyle: TextStyle(
                                    color: colors.hinttext,
                                  ),
                                ),
                                validator: (value) {
                                  if (_reviwe['rate'] == 0) {
                                    showDialog(
                                        context: cxt,
                                        builder: (context) {
                                          Future.delayed(Duration(seconds: 1),
                                              () {
                                            Navigator.of(context).pop(true);
                                          });
                                          return SimpleDialog(
                                            children: [
                                              Text(
                                                'please add rate',
                                                style: TextStyle(
                                                    color: colors.red_base,
                                                    fontSize: 18),
                                              ),
                                            ],
                                          );
                                        });
                                  }
                                },
                                onChanged: (value) {
                                  _reviwe['reviews'] = value;
                                }),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (userReview != null)
                                GestureDetector(
                                  onTap: () {
                                    Customer c1 = Customer();
                                    showDialog<bool>(
                                      context: cxt,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: Text('Delete Review',
                                            style: TextStyle(
                                                color: colors.red_base)),
                                        content: Text(
                                            'Are you sure you want delete the Review? ',
                                            style: TextStyle(
                                                color: colors.black60)),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, false),
                                            child: const Text('Cancel',
                                                style: TextStyle(
                                                    color: colors.blue_base)),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              c1.deleteReview(gymid);
                                              _reviwe['reviews'] = '';
                                              _reviwe['rate'] = 0.0;
                                              User.message(context, false,
                                                  'The review has been deleted');
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              'yes',
                                              style: TextStyle(
                                                  color: colors.red_base),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      "Delete",
                                      style: TextStyle(
                                        color: colors.red_base,
                                        fontFamily: 'Roboto',
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              GestureDetector(
                                onTap: () {
                                  if (_formKey.currentState!.validate() &&
                                      _reviwe['rate'] != 0.0) {
                                    Customer c1 = Customer();

                                    if (_reviwe['reviews'] == '')
                                      c1.addRate(gymid, _reviwe['rate']);
                                    else
                                      c1.addReviwe(gymid, _reviwe['rate'],
                                          _reviwe['reviews']);

                                    _reviwe['rate'] = 0.0;
                                    _reviwe['reviews'] = '';

                                    Navigator.of(cxt).pop();
                                    User.message(cxt, true, 'Thank you!');
                                  }
                                },
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    "Send",
                                    style: TextStyle(
                                      color: colors.blue_base,
                                      fontFamily: 'Roboto',
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          );
        });
  }

  // static Padding commentCard(BuildContext context) {
  //   bool readmore = false;
  //   return Padding(
  //     padding: EdgeInsets.all(10),
  //     child: GestureDetector(
  //       onTap: () {},
  //       child: Container(
  //         child: Column(children: [
  //           Row(
  //             mainAxisSize: MainAxisSize.max,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               CircleAvatar(
  //                 backgroundColor: colors.blue_base,
  //               ),
  //               Padding(
  //                 padding: EdgeInsets.only(left: 10),
  //                 child: Container(
  //                   child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Padding(
  //                             padding: EdgeInsets.only(bottom: 5),
  //                             child: Text('Fahad')),
  //                         Padding(
  //                           padding: EdgeInsets.only(bottom: 5),
  //                           child: Row(children: [
  //                             Icon(Icons.star),
  //                             Icon(Icons.star),
  //                             Icon(Icons.star),
  //                             Icon(Icons.star),
  //                             Icon(Icons.star),
  //                           ]),
  //                         ),
  //                         Padding(
  //                           padding: EdgeInsets.only(bottom: 5),
  //                           child: Container(
  //                             width: MediaQuery.of(context).size.width / 1.6,
  //                             child: Text(
  //                               'datadatadatadatadatadat adatadatadatadatada tadatadat adatadatadata datadatadatadatadatadatada tadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadata',
  //                               maxLines: readmore ? null : 2,
  //                               overflow: TextOverflow.ellipsis,
  //                             ),
  //                           ),
  //                         ),
  //                       ]),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           Container(
  //             child: Align(
  //               alignment: Alignment.bottomRight,
  //               child: Text('yyyy/mm/dd'),
  //             ),
  //           )
  //         ]),
  //       ),
  //     ),
  //   );
  // }

  factory Review.fromjson(Map<String, dynamic> data) {
    return Review(
        uid: data['uid'],
        name: data['name'],
        profileimg: data['profilePicture'],
        rate: data['rate'],
        comment: data['comment'],
        time: data['time'].toString());
  }
}

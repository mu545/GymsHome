import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gymhome/models/GymModel.dart';
// import 'package:gymhome/models/gyms.dart';
// import 'package:provider/provider.dart';
// import 'package:gymhome/provider/gymsitems.dart';
import 'package:gymhome/models/review.dart';
// import 'package:provider/provider.dart';
import 'package:gymhome/Styles.dart';

// import '../provider/customer.dart';
import '../models/user.dart';
import '../widgets/commentCard.dart';
// import 'package:intl/intl.dart';

class GymDescrption extends StatefulWidget {
  GymModel gym;
  final String userid;
  GymDescrption({Key? key, required this.gym, required this.userid})
      : super(key: key);
  static const routeName = '/gym';

  @override
  _GymDescrptionState createState() => _GymDescrptionState();
}

// Customer _currentUser = Customer();

// bool isReviewed = false;

class _GymDescrptionState extends State<GymDescrption> {
//
  List<Review> reviews = [];
  Review? userReview;
// Review userReview = Review(uid:widget.currentUser.uid , name:_currentUser.name, profileimg: _currentUser.profilePicture, rate: 0.0, comment: '', time: '');
  // bool readmore = false;

  ///////////////////////////////////////////////////////////
  void reviewForm(BuildContext bodyctx, Review? userReview, String? gymid) {
    // bool israted;
    double rate = 0.0;
    String comment = '';
    final GlobalKey<FormState> _formKey = GlobalKey();
    if (userReview != null) {
      rate = userReview.rate;
      comment = userReview.comment;
      // israted = true;
    } else {
      rate = 0.0;
      comment = '';
      // israted = true;
    }
    // final Map<String, dynamic> _reviwe = {'reviews': comment, 'rate': rate};
    showDialog(
        context: bodyctx,
        builder: (BuildContext cxt) {
          return Center(
            child: SingleChildScrollView(
              child: AlertDialog(
                  title: Text(
                    "Write a review",
                    style: TextStyle(
                        fontFamily: 'Epilogue',
                        fontSize: 18,
                        color: colors.blue_base),
                  ),
                  content: SizedBox(
                    width: MediaQuery.of(cxt).size.width,
                    child: Column(children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            RatingBar.builder(
                              initialRating: rate,
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 2.0),
                              itemBuilder: (context, _) => Icon(Icons.star,
                                  size: 6, color: colors.yellow_base),
                              onRatingUpdate: (rating) {
                                rate = rating;
                              },
                            ),

                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                  initialValue: comment,
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
                                    // check if rate is null
                                    if (rate == 0) {
                                      // return 'please add rate';
                                    }
                                  },
                                  onChanged: (value) {
                                    comment = value;
                                  }),
                            ),

                            // SizedBox(
                            //   height: 15,
                            //   // ),
                            //   Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       if (userReview != null)
                            //         InkWell(
                            //           onTap: () {
                            //             // Customer c1 = Customer();
                            //             deleteSure(gymid!, userReview.uid);
                            //           },
                            //           child: Align(
                            //             alignment: Alignment.bottomRight,
                            //             child: Text(
                            //               "Delete",
                            //               style: TextStyle(
                            //                 color: colors.red_base,
                            //                 fontFamily: 'Roboto',
                            //                 fontSize: 18,
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //       // GestureDetector(
                            //       //   onTap: () {
                            //       //     if (_formKey.currentState!.validate() &&
                            //       //         rate != 0.0) {
                            //       //       // Customer c1 = Customer();

                            //       //       if (comment == '')
                            //       //         // c1.addRate(gymid, _reviwe['rate']);
                            //       //         // else
                            //       //         // c1.addReviwe(gymid, _reviwe['rate'],
                            //       //         // _reviwe['reviews']);

                            //       //         rate = 0.0;
                            //       //       comment = '';

                            //       //       Navigator.of(cxt).pop();
                            //       //       Provider.of<User>(cxt, listen: false)
                            //       //           .message(cxt, true, 'Thank you!');
                            //       //     }
                            //       //   },
                            //       //   child: Align(
                            //       //     alignment: Alignment.bottomRight,
                            //       //     child: Text(
                            //       //       "Send",
                            //       //       style: TextStyle(
                            //       //         color: colors.blue_base,
                            //       //         fontFamily: 'Roboto',
                            //       //         fontSize: 18,
                            //       //       ),
                            //       //     ),
                            //       //   ),
                            //       // ),
                            //     ],
                            //   ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                  actions: <Widget>[
                    Row(
                      mainAxisAlignment: userReview != null
                          ? MainAxisAlignment.spaceAround
                          : MainAxisAlignment.start,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            primary: colors.blue_base,
                            // minimumSize:
                          ),
                          child: const Text(
                            "Send",
                            style: TextStyle(
                              color: colors.blue_base,
                              fontFamily: 'Roboto',
                              fontSize: 18,
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate() &&
                                rate != 0.0) {
                              // setState(() {});
                              // Customer c1 = Customer();

                              if (comment == '') {
                                try {
                                  Review.addRate(gymid!, rate, widget.userid)
                                      .whenComplete(() {
                                    Navigator.pop(context);
                                    AppUser.message(bodyctx, true, 'Thank you');
                                  });
                                } on FirebaseFirestore catch (e) {
                                  AppUser.message(cxt, false, e.toString());
                                }
                              }

                              // c1.addRate(gymid, _reviwe['rate']);
                              // else
                              // c1.addReviwe(gymid, _reviwe['rate'],
                              // _reviwe['reviews']);

                              // rate = 0.0;
                              // comment = '';

                              // Navigator.of(cxt).pop();
                              // User.message(cxt, true, 'Thank you!');
                            }
                          },
                        ),
                        SizedBox(width: MediaQuery.of(bodyctx).size.width / 3),
                        if (userReview != null)
                          TextButton(
                            style:
                                TextButton.styleFrom(primary: colors.red_base),
                            child: const Text(
                              "Delete",
                              style: TextStyle(
                                color: colors.red_base,
                                fontFamily: 'Roboto',
                                fontSize: 18,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              deleteSure(gymid!, userReview.uid);
                              // if (_formKey.currentState!.validate() &&
                              //     rate != 0.0) {
                              //   // Customer c1 = Customer();

                              //   if (comment == '')
                              //     // c1.addRate(gymid, _reviwe['rate']);
                              //     // else
                              //     // c1.addReviwe(gymid, _reviwe['rate'],
                              //     // _reviwe['reviews']);

                              //     rate = 0.0;
                              //   comment = '';

                              //   Navigator.of(cxt).pop();
                              //   Provider.of<User>(cxt, listen: false)
                              //       .message(cxt, true, 'Thank you!');
                              // }
                            },
                          )
                      ],
                    ),
                  ]),
            ),
          );
        });
  }

  // /////////////////////////////////////////////////////////////////////////
  void deleteSure(String gymid, String uid) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Delete Review', style: TextStyle(color: colors.red_base)),
        content: Text('Are you sure you want delete the Review? ',
            style: TextStyle(color: colors.black60)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child:
                const Text('Cancel', style: TextStyle(color: colors.blue_base)),
          ),
          TextButton(
            onPressed: () {
              Review.deleteReview(gymid, uid).whenComplete(() {
                Navigator.pop(context, true);
                AppUser.message(context, false, 'The review has been deleted');
              });

              // Navigator.pop(context);
            },
            child: const Text(
              'yes',
              style: TextStyle(color: colors.red_base),
            ),
          ),
        ],
      ),
    );
  }

  // void show() {
  //   final GlobalKey<FormState> _formKey = GlobalKey();
  //   Map<String, dynamic> _reviwe = {
  //     'reviews': '',
  //     'rate': 0.0,
  //   };

  //   print('isReviewed');
  //   // print(isReviewed);
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext cxt) {
  //         return Center(
  //           child: SingleChildScrollView(
  //             child: AlertDialog(
  //               content: Container(
  //                 width: MediaQuery.of(context).size.width,
  //                 child: Column(children: [
  //                   Form(
  //                     key: _formKey,
  //                     child: Column(
  //                       mainAxisSize: MainAxisSize.min,
  //                       children: <Widget>[
  //                         Row(
  //                             // mainAxisAlignment: MainAxisAlignment.start,
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               Text(
  //                                 userReview != null
  //                                     ? 'Edit your review'
  //                                     : "Write a review",
  //                                 style: TextStyle(
  //                                     fontFamily: 'Epilogue',
  //                                     fontSize: 18,
  //                                     color: colors.blue_base),
  //                               ),
  //                               GestureDetector(
  //                                 onTap: () {
  //                                   Navigator.of(context).pop();
  //                                 },
  //                                 child: Icon(
  //                                   Icons.cancel_outlined,
  //                                   color: colors.iconscolor,
  //                                   size: 25,
  //                                 ),
  //                               ),
  //                             ]),
  //                         SizedBox(
  //                           height: 20,
  //                         ),
  //                         RatingBar.builder(
  //                           initialRating: 0,
  //                           minRating: 0,
  //                           direction: Axis.horizontal,
  //                           allowHalfRating: false,
  //                           itemCount: 5,
  //                           itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
  //                           itemBuilder: (context, _) => Icon(
  //                             Icons.star,
  //                             size: 6,
  //                             color: colors.yellow_base,
  //                           ),
  //                           onRatingUpdate: (rating) {
  //                             _reviwe['rate'] = rating;
  //                           },
  //                         ),
  //                         SizedBox(
  //                           height: 20,
  //                         ),
  //                         Padding(
  //                           padding: EdgeInsets.all(8.0),
  //                           child: TextFormField(
  //                               maxLines: null,
  //                               obscureText: false,
  //                               keyboardType: TextInputType.emailAddress,
  //                               decoration: InputDecoration(
  //                                 contentPadding: EdgeInsets.all(10),
  //                                 hintText: "review (optional)",
  //                                 hintStyle: TextStyle(
  //                                   color: colors.hinttext,
  //                                 ),
  //                               ),
  //                               validator: (value) {
  //                                 if (_reviwe['rate'] == 0.0) {
  //                                   // error message
  //                                   showDialog(
  //                                       context: context,
  //                                       builder: (context) {
  //                                         return SimpleDialog(
  //                                           children: <Widget>[
  //                                             Center(
  //                                               child: Container(
  //                                                 child: Text(
  //                                                   'please add rate',
  //                                                   style: TextStyle(
  //                                                       color: colors.red_base,
  //                                                       fontSize: 18),
  //                                                 ),
  //                                               ),
  //                                             )
  //                                           ],
  //                                         );
  //                                       });
  //                                 }
  //                               },
  //                               onChanged: (value) {
  //                                 _reviwe['reviews'] = value;
  //                               }),
  //                         ),
  //                         SizedBox(
  //                           height: 10,
  //                         ),
  //                         GestureDetector(
  //                           onTap: () {
  //                             if (_formKey.currentState!.validate() &&
  //                                 _reviwe['rate'] != 0.0) {
  //                               // Customer c1 = Customer();
  //                               // c1.deleteReview('EE6yUxZMs3OK8OotZ0t5');
  //                               // c1 = c1.fromdb;
  //                               print('iam c1');
  //                               // print(c1!.fromdb!.name);
  //                               if (_reviwe['reviews'] == '')
  //                                 c1.addRate(
  //                                     widget.gym.gymId, _reviwe['rate']);
  //                               else
  //                                 c1.addReviwe('EE6yUxZMs3OK8OotZ0t5',
  //                                     _reviwe['rate'], _reviwe['reviews']);

  //                               _reviwe['rate'] = 0.0;
  //                               _reviwe['reviews'] = '';
  //                               Navigator.of(context).pop();
  //                               Provider.of<User>(context, listen: false)
  //                                   .message(cxt, true, 'Thank you!');
  //                               //  message(context, true, 'Thank you!');
  //                             }
  //                           },
  //                           child: Align(
  //                             alignment: Alignment.bottomRight,
  //                             child: Text(
  //                               "Send",
  //                               style: TextStyle(
  //                                 color: colors.blue_base,
  //                                 fontFamily: 'Roboto',
  //                                 fontSize: 18,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ]),
  //               ),
  //             ),
  //           ),
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    GymModel gym = widget.gym;
    String uid = widget.userid;
    double screenWidth = MediaQuery.of(context).size.width;
    // final productid = ModalRoute.of(context)!.settings.arguments as String;
    // final lodedproductr = Provider.of<Gymsitems>(context).FindbyId(productid);
    // final Gym = Provider.of<Gyms>(context);

    return Scaffold(
      //     appBar: AppBar( iconTheme: IconThemeData(
      //   color: Colors.black, //change your color here
      // ),backgroundColor: Colors.white,elevation: 0, ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container(
            //     width: 420,
            //     height: 200,
            //     child: Image.network(
            //       lodedproductr.imageUrl,
            //       fit: BoxFit.cover,
            //     )),
            Row(
              children: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(gym.name ?? '')),
                SizedBox(
                  width: 170,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(widget.gym.gymId ?? '',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 8,
                        ),
                        Icon(Icons.star),
                      ],
                    ),
                    Text(uid),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('55 KM',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    SizedBox(
                      width: 0,
                    ),
                    Icon(Icons.directions_walk)
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Text('Choose sup type'),
                    ],
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      height: 20,
                      width: 390,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            child: FlatButton(
                              child: Text(
                                'Day',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 13),
                              ),
                              color: Colors.white,
                              onPressed: () {/** */},
                            ),
                          ),

                          FlatButton(
                            child: Text(
                              'Month',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13),
                            ),
                            color: Colors.white,
                            onPressed: () {/** */},
                          ),
                          FlatButton(
                            child: Text(
                              '3 Months',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13),
                            ),
                            color: Colors.white,
                            onPressed: () {/** */},
                          ),
                          FlatButton(
                            child: Text(
                              '6 Months',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13),
                            ),
                            color: Colors.white,
                            onPressed: () {/** */},
                          ),
                          // FlatButton(

                          //     child: Text('Month',style: TextStyle(color: Colors.blue , fontSize: 13),),
                          //     color: Colors.white,
                          //     onPressed: () {/** */},

                          // ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Text(lodedproductr.price.toString()),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text(gym.description ?? ''),
                  SizedBox(
                    width: 5,
                  ),
                  Text('_________________________________________________')
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  // Text(lodedproductr.description),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text('Facilites'),
                  SizedBox(
                    width: 5,
                  ),
                  Text('_________________________________________________')
                ],
              ),
            ),
            SizedBox(height: 10),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue),
                        child: FlatButton(
                          child: Text(
                            'Pool',
                            style: TextStyle(color: Colors.blue, fontSize: 13),
                          ),
                          color: Colors.white,
                          onPressed: () {/** */},
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.blue,
                                width: 1,
                                style: BorderStyle.solid),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        width: 73,
                        height: 25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue),
                        child: FlatButton(
                          child: Text(
                            'Sauna',
                            style: TextStyle(color: Colors.blue, fontSize: 13),
                          ),
                          color: Colors.white,
                          onPressed: () {/** */},
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.blue,
                                width: 1,
                                style: BorderStyle.solid),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        width: 76,
                        height: 25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue),
                        child: FlatButton(
                          child: Text(
                            'Rowing',
                            style: TextStyle(color: Colors.blue, fontSize: 13),
                          ),
                          color: Colors.white,
                          onPressed: () {/** */},
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.blue,
                                width: 1,
                                style: BorderStyle.solid),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        width: 76,
                        height: 25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue),
                        child: FlatButton(
                          child: Text(
                            'Squach',
                            style: TextStyle(color: Colors.blue, fontSize: 13),
                          ),
                          color: Colors.white,
                          onPressed: () {/** */},
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.blue,
                                width: 1,
                                style: BorderStyle.solid),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        width: 73,
                        height: 25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue),
                        child: FlatButton(
                          child: Text(
                            'Lokers',
                            style: TextStyle(color: Colors.blue, fontSize: 13),
                          ),
                          color: Colors.white,
                          onPressed: () {/** */},
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.blue,
                                width: 1,
                                style: BorderStyle.solid),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 8,
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      width: 150,
                      height: 25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue),
                      child: FlatButton(
                        child: Text(
                          'Indoor Runing Track',
                          style: TextStyle(color: Colors.blue, fontSize: 13),
                        ),
                        color: Colors.white,
                        onPressed: () {/** */},
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Colors.blue,
                              width: 1,
                              style: BorderStyle.solid),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      width: 66,
                      height: 25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue),
                      child: FlatButton(
                        child: Text(
                          'Khijh',
                          style: TextStyle(color: Colors.blue, fontSize: 13),
                        ),
                        color: Colors.white,
                        onPressed: () {/** */},
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Colors.blue,
                              width: 1,
                              style: BorderStyle.solid),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      width: 100,
                      height: 25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue),
                      child: FlatButton(
                        child: Text(
                          'Steam Bath',
                          style: TextStyle(color: Colors.blue, fontSize: 13),
                        ),
                        color: Colors.white,
                        onPressed: () {/** */},
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Colors.blue,
                              width: 1,
                              style: BorderStyle.solid),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text('Facilites info'),
                ],
              ),
            ),
            // Image.network(lodedproductr.imageUrl),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Colors.black,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Comments'),

                  // print(User.areYousure(
                  //     context,
                  //     'Delete Review',
                  //     'Are you sure you want delete the Review? ',
                  //     () {}));
                  // print(yousure);

                  // showDialog<String>(
                  //   context: context,
                  //   builder: (BuildContext context) => AlertDialog(
                  //     title: const Text('AlertDialog Title'),
                  //     content: const Text('AlertDialog description'),
                  //     actions: [
                  //       TextButton(
                  //         onPressed: () =>
                  //             Navigator.pop(context, 'Cancel'),
                  //         child: const Text('Cancel'),
                  //       ),
                  //       TextButton(
                  //         onPressed: () {
                  //           currentCustomer.deleteReview(gymid);
                  //           User.message(context, false,
                  //               'The review has been deleted');
                  //           setState(() {
                  //             userReview = null;
                  //           });
                  //           Navigator.pop(context, 'OK');
                  //         },
                  //         child: const Text('OK'),
                  //       ),
                  //     ],
                  //   ),
                  // );
                  //   if (yousure == true) {}
                ],
              ),
            ),

            StreamBuilder<QuerySnapshot>(
              stream:
                  //  Provider.of<Review>(context, listen: false)
                  Review.getcomments(gym.gymId ?? ''),
              builder: (context, snapshot) {
                reviews.clear();
                if (snapshot.hasData) {
                  for (QueryDocumentSnapshot<Object?> comment
                      in snapshot.data!.docs) {
                    if (comment.get('uid') == uid) {
                      print('Fahad T');
                      setState(() {
                        userReview = Review.fromList(comment);
                      });
                    }
                    // userReview = Review.fromList(comment);

                    // Review.getUserreview(gymid, currentCustomer.uid)
                    //     .then((value) {

                    // setState(() {});

                    else {
                      print('Fahad F');
                      userReview = null;
                    }

                    // ;
                    // });
                    // });

                    // reviews.add(Provider.of<Review>(context, listen: false)
                    reviews.add(Review.fromList(comment));
                  }

                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: reviews.length,
                      itemBuilder: (BuildContext context, int index) {
                        return commentCard(
                          review: reviews[index],
                        );
                      });
                }

                // <3> Retrieve `List<DocumentSnapshot>` from snapshot

                return CircularProgressIndicator(
                  color: colors.blue_base,
                );
              }, //end then
            ),
          ],
        ),
      ),

      bottomNavigationBar: Row(
        children: [
          InkWell(
            onTap: () {
              reviewForm(context, userReview, widget.gym.gymId);
            },
            // splashColor: colors.blue_base,
            child: Container(
                color: Color.fromARGB(251, 119, 140, 33),
                width: screenWidth / 2,
                height: 50,
                child: Center(
                  child: Text(
                    userReview != null ? 'Edit my review' : "Write a review",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                    ),
                  ),
                )),
          ),
          InkWell(
            // splashColor: colors.blue_base,
            child: Container(
                color: colors.blue_base,
                width: screenWidth / 2,
                height: 50,
                child: Center(
                  child: Text(
                    userReview != null ? 'Edit my review' : "Write a review",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gymhome/models/GymModel.dart';

import 'package:gymhome/models/review.dart';

import 'package:gymhome/Styles.dart';

import '../models/user.dart';
import '../widgets/commentCard.dart';

class GymDescrption extends StatefulWidget {
  GymModel gym;
  final String userid;
  GymDescrption({Key? key, required this.gym, required this.userid})
      : super(key: key);
  static const routeName = '/gym';

  @override
  _GymDescrptionState createState() => _GymDescrptionState();
}

class _GymDescrptionState extends State<GymDescrption> {
//
  List<Review> reviews = [];
  Review? userReview;

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    //   setState(() {});
    // });

    GymModel gym = widget.gym;
    String uid = widget.userid;
    double screenWidth = MediaQuery.of(context).size.width;

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
                  // Text('_________________________________________________')
                ],
              ),
            ),
            Divider(
              color: Colors.black,
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
//Start Commments
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Comments'),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),

            StreamBuilder<QuerySnapshot>(
              stream: Review.getcomments(gym.gymId ?? ''),
              builder: (context, snapshot) {
                reviews.clear();

                if (snapshot.hasData) {
                  for (QueryDocumentSnapshot<Object?> comment
                      in snapshot.data!.docs) {
                    reviews.add(Review.fromList(comment));
                  }
// put user review
                  currentUserRev(reviews);
// show all reviews
                  List<Widget> commentCards = [];
                  for (var item in reviews) {
                    commentCards.add(commentCard(review: item));
                  }
                  return Column(
                    children: commentCards,
                  );
                }

                return CircularProgressIndicator(
                  color: colors.blue_base,
                );
              }, //end then
            ),
          ],
        ),
      ),
// End comments
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
                    // userReview != null ? 'Edit my review' : "Write a review",
                    'Comment',
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
                    // userReview != null ? 'Edit my review' : "Write a review",
                    'Pay',
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

// ignore: slash_for_doc_comments
/** 
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
////////////////////////////////////////////////// Methods //////////////////////////////////////////////////
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 */
// Search for user comment in th comment list
  bool currentUserRev(List<Review> reviews) {
    if (reviews == null) userReview = null;
    for (Review userrev in reviews) {
      if (userrev.uid == widget.userid) {
        print('put data');

        userReview = userrev;

        return true;
      }
    }
    userReview = null;
    return false;
  }

  ///////////////////////////////////////////////////////////
  // Review Form
  void reviewForm(BuildContext bodyctx, Review? userReview, String? gymid) {
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
                                      return 'please add rate';
                                    }
                                  },
                                  onChanged: (value) {
                                    comment = value;
                                  }),
                            ),
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
                              if (comment == '') {
                                Review.addRate(gymid!, rate, widget.userid)
                                    .whenComplete(() {
                                  Navigator.pop(context);
                                  AppUser.message(bodyctx, true, 'Thank you');
                                });
                              } else {
                                Review.addReviwe(
                                        gymid!, rate, comment, widget.userid)
                                    .whenComplete(() {
                                  Navigator.pop(context);
                                  AppUser.message(bodyctx, true, 'Thank you');
                                });
                              }
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
  // Delet Comment
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
              setState(() {
                userReview = null;
              });

              Review.deleteReview(gymid, uid).whenComplete(() {
                Navigator.pop(context, true);
                AppUser.message(context, false, 'The review has been deleted');
              });
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
}

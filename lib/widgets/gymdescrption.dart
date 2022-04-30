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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),

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

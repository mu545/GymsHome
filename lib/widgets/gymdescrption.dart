import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gymhome/models/gyms.dart';

import 'package:gymhome/provider/gymsitems.dart';
import 'package:gymhome/widgets/review.dart';
import 'package:provider/provider.dart';
import 'package:gymhome/Styles.dart';

import '../models/customer.dart';
import '../models/user.dart';
import 'package:intl/intl.dart';

class GymDescrption extends StatefulWidget {
  const GymDescrption({Key? key}) : super(key: key);
  static const routeName = '/gym';

  @override
  _GymDescrptionState createState() => _GymDescrptionState();
}

bool readmore = false;
Customer currentCustomer = Customer();
String gymid = 'EE6yUxZMs3OK8OotZ0t5';
// bool isReviewed = false;
List<Review> reviews = [];
Review? userReview = null;

class _GymDescrptionState extends State<GymDescrption> {
  void getisReviewed() {}

  @override
  void show() {
    final GlobalKey<FormState> _formKey = GlobalKey();
    Map<String, dynamic> _reviwe = {
      'reviews': '',
      'rate': 0.0,
    };

    print('isReviewed');
    // print(isReviewed);
    showDialog(
        context: context,
        builder: (BuildContext cxt) {
          return Center(
            child: SingleChildScrollView(
              child: AlertDialog(
                content: Container(
                  width: MediaQuery.of(context).size.width,
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
                                  userReview != null
                                      ? 'Edit your review'
                                      : "Write a review",
                                  style: TextStyle(
                                      fontFamily: 'Epilogue',
                                      fontSize: 18,
                                      color: colors.blue_base),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Icon(
                                    Icons.cancel_outlined,
                                    color: colors.iconscolor,
                                    size: 25,
                                  ),
                                ),
                              ]),
                          SizedBox(
                            height: 20,
                          ),
                          RatingBar.builder(
                            initialRating: 0,
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
                                  if (_reviwe['rate'] == 0.0) {
                                    // error message
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return SimpleDialog(
                                            children: <Widget>[
                                              Center(
                                                child: Container(
                                                  child: Text(
                                                    'please add rate',
                                                    style: TextStyle(
                                                        color: colors.red_base,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                              )
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
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate() &&
                                  _reviwe['rate'] != 0.0) {
                                Customer c1 = Customer();
                                // c1.deleteReview('EE6yUxZMs3OK8OotZ0t5');
                                // c1 = c1.fromdb;
                                print('iam c1');
                                // print(c1!.fromdb!.name);
                                if (_reviwe['reviews'] == '')
                                  c1.addRate(
                                      'EE6yUxZMs3OK8OotZ0t5', _reviwe['rate']);
                                else
                                  c1.addReviwe('EE6yUxZMs3OK8OotZ0t5',
                                      _reviwe['rate'], _reviwe['reviews']);

                                _reviwe['rate'] = 0.0;
                                _reviwe['reviews'] = '';
                                Navigator.of(context).pop();
                                User.message(context, true, 'Thank you!');
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
                    ),
                  ]),
                ),
              ),
            ),
          );
        });
  }

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // final productid = ModalRoute.of(context)!.settings.arguments as String;
    // final lodedproductr = Provider.of<Gymsitems>(context).FindbyId(productid);
    final Gym = Provider.of<Gyms>(context);

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
                    child: Text(Gym.title)),
                SizedBox(
                  width: 170,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Text('4.5',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 8,
                        ),
                        Icon(Icons.star),
                      ],
                    ),
                    Text('Based on 320 Reviews'),
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
                  Text(Gym.description),
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
                  if (userReview != null)
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(colors.red_base),
                      ),
                      child: Text('Delete my reviwe'),
                      onPressed: () {
                        bool yousure = User.areYousure(context, 'Delete Review',
                            'Are you sure you want delete the Review? ', () {});
                        // print(User.areYousure(
                        //     context,
                        //     'Delete Review',
                        //     'Are you sure you want delete the Review? ',
                        //     () {}));
                        // print(yousure);
                        if (yousure) {
                          currentCustomer.deleteReview(gymid);
                          User.message(
                              context, false, 'The review has been deleted');
                          setState(() {
                            userReview = null;
                          });
                        }
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
                      },
                    ),
                ],
              ),
            ),
            //
            StreamBuilder<QuerySnapshot>(
              // <2> Pass `Stream<QuerySnapshot>` to stream
              stream: Review.getcomments(gymid),
              builder: (context, snapshot) {
                // List<Padding> comments = [];
                reviews.clear();
                if (snapshot.hasData) {
                  // for (var d in snapshot.data!.docs) {
                  //   print(snapshot.data!.docs);
                  //   var year = d.get('time').toDate().year;
                  //   var month = d.get('time').toDate().month;
                  //   var day = d.get('time').toDate().day;
                  //   String time =
                  //       DateFormat.yMMMMd().format(DateTime(year, month, day));

                  //   comments.add(commentCard(
                  //       context,
                  //       d.get('name'),
                  //       d.get('comment'),
                  //       d.get('rate').round(),
                  //       d.get('profilePicture'),
                  //       time));
                  // }
                  // else{
                  // Text('Be the first');}
                  for (QueryDocumentSnapshot<Object?> comment
                      in snapshot.data!.docs) {
                    if (comment.get('uid') == currentCustomer.uid)
                      Review.getUserreview(gymid, currentCustomer.uid)
                          .then((value) {
                        setState(() {
                          userReview = value;
                        });
                      });

                    reviews.add(Review.fromList(comment));
                  }

                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: reviews.length,
                      itemBuilder: (BuildContext context, int index) {
                        // return ListTile(

                        //     leading: Icon(Icons.list),
                        //     trailing: Text(
                        //       "GFG",
                        //       style: TextStyle(
                        //           color: Colors.green, fontSize: 15),
                        //     ),
                        //     title: Text("List item $index"));
                        // Container(color: colors.green_base);
                        return commentCard(context, reviews[index]);
                      });

                  // return SingleChildScrollView(
                  //   child: Column(
                  //     children: comments,
                  //   ),
                  // );

                }

                // <3> Retrieve `List<DocumentSnapshot>` from snapshot

                return CircleAvatar(
                  // radius: 80.0,
                  backgroundColor: colors.blue_smooth,
                  child: Center(),
                );
              }, //end then
            ),
          ],
        ),
      ),

      bottomNavigationBar: Row(
        children: [
          TextButton(
            style: TextButton.styleFrom(
              minimumSize: Size(screenWidth / 2, 20),
              primary: colors.blue_base,
            ),
            onPressed: () {
              print('getuserreview');
              // if (isReviewed)
              // Review.getUserreview(gymid, currentCustomer.uid).then((value) {
              //   if (value != null)
              //     setState(() {
              //       // print('setisReviewed false');
              //       // isReviewed = true;
              //     });
              // else
              //   setState(() {
              //     // print('setisReviewed true');
              //     // isReviewed = false;
              //   });
              // Review.show(context, userReview);
              // print(userReview!.name);
              Review.getUserreview(gymid, currentCustomer.uid).then((value) {
                userReview = value;
                Review.show(context, userReview, gymid);
                // print(userReview!.name);
              });
              // print('------------------------------');
              // }
              //   );
              // else
              //   Review.show(context, null);
            },
            child: Text(
              userReview != null ? 'Edit my review' : "Write a review",
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              minimumSize: Size(screenWidth / 2, 20),
              primary: colors.blue_base,
            ),
            onPressed: () {},
            child: Text('show'),
          ),
        ],
      ),
    );
  }

  commentCard(BuildContext context, Review r1) {
    double screenWidth = MediaQuery.of(context).size.width - 100;
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(r1.profileimg),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: SizedBox(
                width: screenWidth,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Text(
                                  r1.name,
                                  style: TextStyle(
                                      color: colors.blue_base, fontSize: 18),
                                )),
                            SizedBox(
                              width: screenWidth / 2,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    for (var i = 0; i < r1.rate; i++)
                                      Icon(
                                        Icons.star,
                                        size: 25,
                                        color: colors.yellow_base,
                                      ),
                                  ]),
                            ),
                          ]),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Container(
                          // width: MediaQuery.of(context).size.width / 1.6,
                          child: Text(
                            r1.comment,
                            maxLines: readmore ? null : 2,
                            overflow: readmore
                                ? TextOverflow.visible
                                : TextOverflow.fade,
                            style:
                                TextStyle(color: colors.black60, fontSize: 15),
                          ),
                        ),
                      ),
                      if (r1.comment.length > 90)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              readmore = !readmore;
                            });
                          },
                          child: Text(
                            readmore ? 'read less' : 'read more',
                            style: TextStyle(
                                color: colors.blue_base, fontSize: 13),
                          ),
                        )
                    ]),
              ),
            ),
          ],
        ),
        Container(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Text(r1.time.toString()),
          ),
        ),
        Divider(
          color: colors.black60,
        ),
      ]),
    );
  }
}

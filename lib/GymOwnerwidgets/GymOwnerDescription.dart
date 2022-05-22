import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gymhome/GymOwnerwidgets/gymprice.dart';
import 'package:gymhome/GymOwnerwidgets/ownerhome.dart';
import 'package:gymhome/GymOwnerwidgets/subscribed.dart';
import 'package:gymhome/models/GymModel.dart';
import 'package:gymhome/models/Owner.dart';
import 'package:gymhome/widgets/edit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:gymhome/models/review.dart';
import 'package:gymhome/Styles.dart';
import '../models/user.dart';
import '../widgets/commentCard.dart';
import '../widgets/locationmap.dart';

class GymOwnerDescrption extends StatefulWidget {
  GymModel gym;
  List<Placelocation> gymsaddress;
  //final String userid;
  GymOwnerDescrption({
    Key? key,
    // required this.distance,
    required this.gymsaddress,
    required this.gym,
  }) : super(key: key);
  static const routeName = '/gym';

  @override
  _GymOwnerDescrptionState createState() => _GymOwnerDescrptionState();
}

class _GymOwnerDescrptionState extends State<GymOwnerDescrption> {
  // int pricess = 6;
  GeoPoint? userLocation;
  String distance = 'Loading...';
  List<Review> reviews = [];
  Review? userReview;
  String currentPrice = '';
  List<String> listReviews = [];
  int activeIndex = 0;
  final controller = CarouselController();
  String? window = 'Description';
  windowChoose(windows) {
    switch (windows) {
      case 'Comments':
        setState(() {
          window = 'Comments';
        });
        print('comm');
        break;
      case 'Facilities':
        setState(() {
          window = "Facilities";
        });
        print('fac');
        break;
      case 'Description':
        setState(() {
          window = 'Description';
        });
        print('des');
        break;
      // default:
      //   setState(() {
      //     window = '';
      //   });
    }
  }

  @override
  void initState() {
    super.initState();
    Geolocator.getCurrentPosition().then((value) {
      setState(() {
        userLocation = GeoPoint(value.latitude, value.longitude);
      });
    }).whenComplete(() => getDistance());
  }

  void getDistance() async {
    // final Position locdata = await Geolocator.getCurrentPosition();
    // GeoPoint userLocation = GeoPoint(locdata.latitude, locdata.longitude);
    final _dis = await Placelocation.calculateDistance(
        widget.gym.location!, userLocation!);
    // if (mounted)
    setState(() {
      distance = _dis;
    });
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: widget.gym.images!.length,
        onDotClicked: animateToSlide,
        effect: ScrollingDotsEffect(
          //   strokeWidth: 100,
          dotHeight: 10,
          dotWidth: 10,
          activeDotColor: colors.blue_base,
          dotColor: Colors.grey,
        ),
      );

  void animateToSlide(int index) => controller.animateToPage(index);

  Widget buildImage(String urlImage, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        color: Colors.grey,
        child: Image.network(
          urlImage,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.white,
              alignment: Alignment.center,
              child: const Text(
                'Whoops!',
                style: TextStyle(fontSize: 30, color: colors.black60),
              ),
            );
          },
        ),
      ); // Container
  Widget display() {
    if (window == 'Description') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 30,
          ),
          Expanded(
              child: Container(
            // decoration: BoxDecoration(
            //    borderRadius: BorderRadius.circular(10.0),
            //   border: Border.all(color: colors.blue_smooth),
            //  ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(
                  widget.gym.description ?? '',
                  style: TextStyle(fontFamily: 'Roboto', fontSize: 18),
                ),
              ),
            ),
          )),
          SizedBox(
            width: 30,
          ),
        ],
      );
    } else if (window == "Comments") {
      return StreamBuilder<QuerySnapshot>(
        stream: Review.getcomments(widget.gym.gymId ?? ''),
        builder: (context, snapshot) {
          reviews.clear();

          if (snapshot.hasData) {
            for (QueryDocumentSnapshot<Object?> comment
                in snapshot.data!.docs) {
              reviews.add(Review.fromList(comment));
            }
// put user review
// currentUserRev(reviews);
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
      );
    } else if (window == 'Facilities') {
      return Column(
        children: [
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (var fac in widget.gym.faciltrs!)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: colors.blue_smooth),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      child: Text(
                        fac,
                        style: TextStyle(color: colors.blue_base),
                      ),
                    ),
                  ),
                )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.black,
          ),
          SizedBox(
            height: 10,
          ),
          Center(
              child: widget.gym.images!.isNotEmpty
                  ? CarouselSlider.builder(
                      carouselController: controller,
                      options: CarouselOptions(
                        height: 400,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) =>
                            setState(() => activeIndex = index),
                      ),
                      itemCount: widget.gym.images!.length,
                      itemBuilder: (context, index, realIndex) {
                        final urlImage = widget.gym.images![index];
                        return buildImage(urlImage, index);
                      },
                    )
                  : Container(
                      child: Text('There are no images uploaded for this gym'),
                    )),
          SizedBox(
            height: 20,
          ),
          widget.gym.images!.isNotEmpty
              ? buildIndicator()
              : SizedBox(
                  height: 20,
                ),
        ],
      );
    }
    return Text('data');
  }

  deleteGym() {
    var snapshot = FirebaseFirestore.instance
        .collection('gyms')
        .doc(widget.gym.gymId)
        .collection('Review')
        .snapshots();
    //Delete reviews
    FirebaseFirestore.instance
        .collection('gyms')
        .doc(widget.gym.gymId)
        .collection('Review')
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });

    snapshot.forEach((element) {
      element.docs.clear();
    });
    listReviews.clear();
    snapshot.forEach((element) {
      element.docs.forEach((element) {
        setState(() {
          listReviews.add(element.id);
        });
      });
      print(listReviews);
      if (listReviews.isNotEmpty) {
        for (var i = 0; i < listReviews.length; i++) {
          print(listReviews);
          FirebaseFirestore.instance
              .collection('Customer')
              .doc(listReviews[i])
              .update({
            'reviews': FieldValue.arrayRemove([widget.gym.gymId])
          }).then((value) => {
                    FirebaseFirestore.instance
                        .collection('gyms')
                        .doc(widget.gym.gymId)
                        .delete()
                        .then((value) => Navigator.of(context).pop())
                  });
        }
      } else {
        FirebaseFirestore.instance
            .collection('gyms')
            .doc(widget.gym.gymId)
            .delete()
            .then((value) => Navigator.of(context).pop());
      }
    });
    AppUser.message(context, true, "Gym is Deleted");
  }

  Widget AlertDialogs() {
    return AlertDialog(
      title: Text(
        'Delete Gym?',
        style: TextStyle(color: colors.red_base),
      ),
      content: Text('Are you sure you want to delete this gym?'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              deleteGym();
            },
            child: Text(
              'Yes',
              style: TextStyle(color: colors.red_base),
            )),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'No',
              style: TextStyle(color: colors.blue_base),
            )),
      ],
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 24,
      // backgroundColor: colors.blue_smooth,
    );
  }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    //   setState(() {});
    // });

    GymModel gym = widget.gym;
    // String uid = widget.gym.ownerId!;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: screenWidth,
                  height: 200,
                  child: Image.network(
                    gym.imageURL ?? '',
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  top: 170,
                  left: 5,
                  child: Container(
                    child: Text(
                      gym.name ?? '',
                      style: TextStyle(
                          //   color: Colors.white,
                          fontFamily: 'Epilogue',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          //  fontStyle: FontStyle.italic,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 1
                            ..color = colors.black100),
                    ),
                  ),
                ),
                Positioned(
                  top: 170,
                  left: 5,
                  child: Container(
                    child: Text(
                      gym.name ?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Epilogue',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        //    fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Colors.black,
            ),
            Card(
              margin: EdgeInsets.all(10),
              elevation: 2,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                distance,
                                style: TextStyle(fontSize: 20),
                              ),
                              Icon(Icons.directions_walk_outlined)
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Subscribed(
                                        gymid: gym.gymId!,
                                        // ownerid: uid!,
                                        // gymsList: _gymsList,
                                      )));
                            },
                            child: Text(
                              'Subscribed',
                              style: TextStyle(
                                  color: colors.blue_base, fontSize: 15),
                            ),

                            // icon: Icon(
                            //   Icons.subscrip,
                            //   // color: colors.blue_base,
                            //   // size: 35,
                            //   // color: colors.red_base,
                            // ), label:Text('Subscribed'),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                gym.avg_rate.toString(),
                                style: TextStyle(fontSize: 25),
                              ),
                              Icon(
                                Icons.star,
                                color: colors.yellow_base,
                                size: 45,
                              ),
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Text(
                                widget.gym.reviews == 0
                                    ? 'No reviews yet'
                                    : "Based on " +
                                        widget.gym.reviews.toString() +
                                        " reviews",
                              )),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    height: 32,
                    // width: 200,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(7)),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.all(0)),
                              backgroundColor:
                                  currentPrice == gym.priceOneDay.toString()
                                      ? MaterialStateProperty.all(
                                          Color.fromARGB(209, 71, 153, 183))
                                      : MaterialStateProperty.all(Colors.white),
                            ),
                            onPressed: gym.priceOneDay == 0
                                ? null
                                : () {
                                    setState(() {
                                      currentPrice = gym.priceOneDay.toString();
                                    });
                                  },
                            child: Text(
                              'Day',
                              style: TextStyle(
                                fontSize: 13,
                                color:
                                    currentPrice == gym.priceOneDay.toString()
                                        ? Colors.white
                                        : gym.priceOneDay == 0
                                            ? Colors.grey
                                            : Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  currentPrice == gym.priceOneMonth.toString()
                                      ? MaterialStateProperty.all(
                                          Color.fromARGB(209, 71, 153, 183))
                                      : MaterialStateProperty.all(Colors.white),
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.all(0)),
                            ),
                            onPressed: gym.priceOneMonth == 0
                                ? null
                                : () {
                                    setState(() {
                                      currentPrice =
                                          gym.priceOneMonth.toString();
                                    });
                                  },
                            child: Text(
                              'Month',
                              style: TextStyle(
                                fontSize: 13,
                                color:
                                    currentPrice == gym.priceOneMonth.toString()
                                        ? Colors.white
                                        : gym.priceOneMonth == 0
                                            ? Colors.grey
                                            : Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: currentPrice ==
                                      gym.priceThreeMonths.toString()
                                  ? MaterialStateProperty.all(
                                      Color.fromARGB(209, 71, 153, 183))
                                  : MaterialStateProperty.all(Colors.white),
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.all(0)),
                            ),
                            onPressed: gym.priceThreeMonths == 0
                                ? null
                                : () {
                                    setState(() {
                                      currentPrice =
                                          gym.priceThreeMonths.toString();
                                    });
                                  },
                            child: Text(
                              '3 Months',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: currentPrice ==
                                        gym.priceThreeMonths.toString()
                                    ? Colors.white
                                    : gym.priceThreeMonths == 0
                                        ? Colors.grey
                                        : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  currentPrice == gym.priceSixMonths.toString()
                                      ? MaterialStateProperty.all(
                                          Color.fromARGB(209, 71, 153, 183))
                                      : MaterialStateProperty.all(Colors.white),
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.all(0)),
                            ),
                            onPressed: gym.priceSixMonths == 0
                                ? null
                                : () {
                                    setState(() {
                                      currentPrice =
                                          gym.priceSixMonths.toString();
                                    });
                                  },
                            child: Text(
                              '6 Months',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: currentPrice ==
                                        gym.priceSixMonths.toString()
                                    ? Colors.white
                                    : gym.priceSixMonths == 0
                                        ? Colors.grey
                                        : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  currentPrice == gym.priceOneYear.toString()
                                      ? MaterialStateProperty.all(
                                          Color.fromARGB(209, 71, 153, 183))
                                      : MaterialStateProperty.all(Colors.white),
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.all(0)),
                            ),
                            onPressed: gym.priceOneYear == 0
                                ? null
                                : () {
                                    setState(() {
                                      currentPrice =
                                          gym.priceOneYear.toString();
                                    });
                                  },
                            child: Text(
                              'Year',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color:
                                    currentPrice == gym.priceOneYear.toString()
                                        ? Colors.white
                                        : gym.priceOneYear == 0
                                            ? Colors.grey
                                            : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //  decoration: BoxDecoration(color: colors.black100),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Container(
                        child: currentPrice != ''
                            ? Text(
                                "${currentPrice} SAR",
                                style: TextStyle(fontSize: 30),
                              )
                            : Text('')),
                  ]),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              // margin: EdgeInsets.all(value),
              child: Card(
                  elevation: 2,
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                                child: Container(
                                  margin: EdgeInsets.only(),
                                  height: 30,
                                  width: 100,
                                  //  color: colors.red_base,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    color: window == 'Description'
                                        ? Color.fromARGB(195, 71, 153, 183)
                                        : Colors.white,
                                  ),
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text('Description',
                                          style: TextStyle(
                                            color: window == 'Description'
                                                ? Colors.white
                                                : Colors.black,
                                          )),
                                    ],
                                  )),
                                ),
                                onTap: () {
                                  windowChoose('Description');
                                }),
                          ),
                          Expanded(
                            child: InkWell(
                              child: Container(
                                margin: EdgeInsets.only(),
                                height: 30,
                                width: 100,
                                //  color: colors.red_base,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                  color: window == 'Facilities'
                                      ? Color.fromARGB(195, 71, 153, 183)
                                      : Colors.white,
                                ),
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      'Facilities',
                                      style: TextStyle(
                                        color: window == 'Facilities'
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    )
                                  ],
                                )),
                              ),
                              onTap: () {
                                windowChoose("Facilities");
                              },
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              child: Container(
                                margin: EdgeInsets.only(),
                                height: 30,
                                width: 100,
                                //  color: colors.red_base,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                  color: window == 'Comments'
                                      ? Color.fromARGB(195, 71, 153, 183)
                                      : Colors.white,
                                ),
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      'Comments',
                                      style: TextStyle(
                                        color: window == 'Comments'
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    )
                                  ],
                                )),
                              ),
                              onTap: () {
                                windowChoose('Comments');
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      display(),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 15,
            )
          ],
        ),
      ),
// End comments
      bottomNavigationBar: Row(
        children: [
          InkWell(
            onTap: () {
              File? imageFile;

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddGymInfo(
                        gymsaddress: widget.gymsaddress,
                        gym: gym,
                        imageFile: null,
                        oldGym: true,
                      )));
            },
            // splashColor: colors.blue_base,
            child: Container(
                color: colors.blue_base,
                width: screenWidth / 2,
                height: 50,
                child: Center(
                  child: Text(
                    'Edit Gym',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                    ),
                  ),
                )),
          ),
          InkWell(
            onTap: () {
              showDialog(context: context, builder: (_) => AlertDialogs());
            },
            child: Container(
                color: Color.fromARGB(230, 234, 60, 47),
                width: screenWidth / 2,
                height: 50,
                child: Center(
                  child: Text(
                    // userReview != null ? 'Edit my review' : "Write a review",
                    'Delete Gym',
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

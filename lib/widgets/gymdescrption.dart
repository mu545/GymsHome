// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gymhome/GymOwnerwidgets/gymprice.dart';
import 'package:gymhome/models/GymModel.dart';
import 'package:gymhome/widgets/PaymentScreen.dart';
import 'package:gymhome/widgets/Stripe.dart';
import 'package:gymhome/widgets/customermap.dart';
import 'package:gymhome/widgets/locationmap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:gymhome/models/review.dart';
import 'package:gymhome/Styles.dart';
import '../models/user.dart';
import '../widgets/commentCard.dart';

class GymDescrption extends StatefulWidget {
  GymModel gym;
  String userid;
  String price;
  GymDescrption(
      {Key? key, required this.gym, required this.userid, required this.price})
      : super(key: key);
  static const routeName = '/gym';

  @override
  _GymDescrptionState createState() => _GymDescrptionState();
}

class _GymDescrptionState extends State<GymDescrption> {
  @override
  void initState() {
    super.initState();
    Geolocator.getCurrentPosition().then((value) {
      setState(() {
        userLocation = GeoPoint(value.latitude, value.longitude);
      });
    }).whenComplete(() => getDistance());
  }

  void payNow() async {
    //the amount must be transformed to cents

    var response = await StripeServices.payNowHandler(
        amount: currentPrice, currency: 'USD');
    print(currentPrice);
    print('response message ${response.message}');
    print('meowssss');
  }

  String distance = 'Loading...';
  GeoPoint? userLocation;
  List<Review> reviews = [];
  Review? userReview;
  String currentPrice = '';
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
      case 'Facilites':
        setState(() {
          window = "Facilites";
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

  String showPrice() {
    // String price = 's';
    switch (widget.price) {
      case 'One Day':
        setState(() {
          currentPrice = widget.gym.priceOneDay.toString();
        });
        return currentPrice;
      case 'One Month':
        setState(() {
          currentPrice = widget.gym.priceOneMonth.toString();
        });
        return currentPrice;
      case 'Three Months':
        setState(() {
          currentPrice = widget.gym.priceThreeMonths.toString();
        });
        return currentPrice;
      case 'Six Months':
        setState(() {
          currentPrice = widget.gym.priceSixMonths.toString();
        });
        return currentPrice;
      case 'One Year':
        setState(() {
          currentPrice = widget.gym.priceOneYear.toString();
        });
        return currentPrice;
      default:
        return '';
    }
  }

  void getDistance() async {
    // final Position locdata = await Geolocator.getCurrentPosition();
    // GeoPoint userLocation = GeoPoint(locdata.latitude, locdata.longitude);
    final _dis = await Placelocation.calculateDistance(
        widget.gym.location!, userLocation!);
    if (mounted)
      setState(() {
        distance = _dis;
      });
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: widget.gym.images!.length,
        onDotClicked: animateToSlide,
        effect: ScrollingDotsEffect(
            activeDotColor: colors.blue_base,
            dotColor: Colors.grey,
            dotHeight: 12,
            dotWidth: 12),
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
      );
    } else if (window == 'Facilites') {
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
                      child: Text('Three is no images uploaded for this gym'),
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

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    //   setState(() {});
    // });
    print(widget.price);
    GymModel gym = widget.gym;
    String uid = widget.userid;
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
                            ..strokeWidth = 6
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  ' ' + distance,
                                  style: TextStyle(fontSize: 20),
                                ),
                                Icon(Icons.directions_walk_outlined),
                              ],
                            ),
                            TextButton.icon(
                              label: Text(
                                'See Location',
                                style: TextStyle(
                                    color: colors.blue_base, fontSize: 15),
                              ),
                              icon: const Icon(
                                Icons.near_me_rounded,
                                size: 25,
                                color: colors.blue_base,
                              ),

                              // style: ButtonStyle(

                              //     backgroundColor: MaterialStateProperty.all(
                              //         Color.fromARGB(209, 71, 153, 183))),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Customermap(
                                          gym: gym,
                                        )));
                              },
                            ),
                            // IconButton(
                            //     onPressed: () => {},
                            //     icon: const Icon(
                            //       Icons.near_me_rounded,
                            //       size: 35,
                            //       color: colors.blue_base,
                            //     )),
                          ],
                        ),
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
                  // Row(
                  //   children: [
                  //     Customermap(
                  //       gym: gym,
                  //     )
                  //   ],
                  // ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        height: 20,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          children: [
                            gym.priceOneDay != 0
                                ? ElevatedButton(
                                    child: Text(
                                      'Day',
                                      style: TextStyle(
                                          color: currentPrice ==
                                                  gym.priceOneDay.toString()
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 13),
                                    ),
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                OutlinedBorder>(
                                            RoundedRectangleBorder(
                                                side: BorderSide.none)),
                                        backgroundColor: currentPrice ==
                                                gym.priceOneDay.toString()
                                            ? MaterialStateProperty.all(
                                                Color.fromARGB(
                                                    209, 71, 153, 183))
                                            : MaterialStateProperty.all(
                                                Colors.white)),
                                    onPressed: () {
                                      setState(() {
                                        currentPrice =
                                            gym.priceOneDay.toString();
                                      });
                                    },
                                  )
                                : Container(
                                    margin: EdgeInsets.only(left: 10),
                                    width: 30,
                                    child: Text(
                                      'Day',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                            gym.priceOneMonth != 0
                                ? ElevatedButton(
                                    child: Text(
                                      'Month',
                                      style: TextStyle(
                                          color: currentPrice ==
                                                  gym.priceOneMonth.toString()
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 13),
                                    ),
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                OutlinedBorder>(
                                            RoundedRectangleBorder(
                                                side: BorderSide.none)),
                                        backgroundColor: currentPrice ==
                                                gym.priceOneMonth.toString()
                                            ? MaterialStateProperty.all(
                                                Color.fromARGB(
                                                    209, 71, 153, 183))
                                            : MaterialStateProperty.all(
                                                Colors.white)),
                                    onPressed: () {
                                      setState(() {
                                        currentPrice =
                                            gym.priceOneMonth.toString();
                                      });
                                    },
                                  )
                                : Container(
                                    margin: EdgeInsets.only(left: 20),
                                    width: 50,
                                    child: Text(
                                      'Month',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                            gym.priceThreeMonths != 0
                                ? ElevatedButton(
                                    child: Text(
                                      '3 Months',
                                      style: TextStyle(
                                          color: currentPrice ==
                                                  gym.priceThreeMonths
                                                      .toString()
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 13),
                                    ),
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                OutlinedBorder>(
                                            RoundedRectangleBorder(
                                                side: BorderSide.none)),
                                        backgroundColor: currentPrice ==
                                                gym.priceThreeMonths.toString()
                                            ? MaterialStateProperty.all(
                                                Color.fromARGB(
                                                    209, 71, 153, 183))
                                            : MaterialStateProperty.all(
                                                Colors.white)),
                                    onPressed: () {
                                      setState(() {
                                        currentPrice =
                                            gym.priceThreeMonths.toString();
                                      });
                                    },
                                  )
                                : Container(
                                    margin: EdgeInsets.only(left: 20),
                                    width: 80,
                                    child: Text(
                                      '3 Months',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                            gym.priceSixMonths != 0
                                ? ElevatedButton(
                                    child: Text(
                                      '6 Months',
                                      style: TextStyle(
                                          color: currentPrice ==
                                                  gym.priceSixMonths.toString()
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 13),
                                    ),
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                OutlinedBorder>(
                                            RoundedRectangleBorder(
                                                side: BorderSide.none)),
                                        backgroundColor: currentPrice ==
                                                gym.priceSixMonths.toString()
                                            ? MaterialStateProperty.all(
                                                Color.fromARGB(
                                                    209, 71, 153, 183))
                                            : MaterialStateProperty.all(
                                                Colors.white)),
                                    onPressed: () {
                                      setState(() {
                                        currentPrice =
                                            gym.priceSixMonths.toString();
                                      });
                                    },
                                  )
                                : Container(
                                    margin: EdgeInsets.only(left: 10),
                                    width: 80,
                                    child: Text(
                                      '6 Months',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                            gym.priceOneYear != 0
                                ? ElevatedButton(
                                    child: Text(
                                      'Year',
                                      style: TextStyle(
                                          color: currentPrice ==
                                                  gym.priceOneYear.toString()
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 13),
                                    ),
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                OutlinedBorder>(
                                            RoundedRectangleBorder(
                                                side: BorderSide.none)),
                                        backgroundColor: currentPrice ==
                                                gym.priceOneYear.toString()
                                            ? MaterialStateProperty.all(
                                                Color.fromARGB(
                                                    209, 71, 153, 183))
                                            : MaterialStateProperty.all(
                                                Colors.white)),
                                    onPressed: () {
                                      setState(() {
                                        currentPrice =
                                            gym.priceOneYear.toString();
                                      });
                                    },
                                  )
                                : Container(
                                    margin: EdgeInsets.only(left: 20),
                                    width: 50,
                                    child: Text(
                                      'Year',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
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
                            : Text(
                                showPrice() + '',
                                style: TextStyle(fontSize: 30),
                              )),
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
                                          ? Color.fromARGB(209, 71, 153, 183)
                                          : Colors.white),
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        'Description',
                                        style: TextStyle(
                                            color: window == 'Description'
                                                ? Colors.white
                                                : Colors.black),
                                      ),
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
                                    color: window == 'Facilites'
                                        ? Color.fromARGB(209, 71, 153, 183)
                                        : Colors.white),
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      'Facilites',
                                      style: TextStyle(
                                          color: window == 'Facilites'
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ],
                                )),
                              ),
                              onTap: () {
                                windowChoose("Facilites");
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
                                        ? Color.fromARGB(209, 71, 153, 183)
                                        : Colors.white),
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      'Reviews',
                                      style: TextStyle(
                                          color: window == 'Comments'
                                              ? Colors.white
                                              : Colors.black),
                                    ),
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
              print('uid' + widget.userid.toString());
              print('gymid' + widget.gym.gymId.toString());
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
            onTap: () {
              payNow();
            },
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
                                    .then((value) => AppUser.message(
                                        bodyctx, true, 'Thank you'))
                                    .onError((error, stackTrace) =>
                                        AppUser.message(
                                            bodyctx, false, error.toString()));

                                Navigator.pop(context);

                                ;
                              } else {
                                Review.addReviwe(
                                        gymid!, rate, comment, widget.userid)
                                    .then((value) => AppUser.message(
                                        bodyctx, true, 'Thank you'))
                                    .onError((error, stackTrace) =>
                                        AppUser.message(
                                            bodyctx, false, error.toString()));

                                Navigator.pop(context);
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

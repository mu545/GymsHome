// import 'dart:html';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gymhome/GymOwnerwidgets/gymprice.dart';
import 'package:gymhome/models/GymModel.dart';
import 'package:gymhome/widgets/PaymentScreen.dart';
import 'package:gymhome/widgets/Stripe.dart';
import 'package:gymhome/widgets/customermap.dart';
import 'package:gymhome/widgets/locationmap.dart';
import 'package:ntp/ntp.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:gymhome/models/review.dart';
import 'package:gymhome/Styles.dart';
import '../models/user.dart';
import '../widgets/commentCard.dart';

class RateFiledValidator {
  static String? validate(String value) {
    return (value.isEmpty) ? 'Please Add rate' : null;
  }
}

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
    isSubscribed();
    Geolocator.getCurrentPosition().then((value) {
      setState(() {
        userLocation = GeoPoint(value.latitude, value.longitude);
      });
    }).whenComplete(() => getDistance());
  }

  // payNow() async {
  //   //the amount must be transformed to cents

  //   var response =
  //       await StripeServices.payNowHandler(amount: '888', currency: 'USD');

  //   print(currentPrice);
  //   print('response message ${response.message}');
  //   print('meowssss');
  // }
  Map<String, dynamic> _data = {
    'Owner Name': '',
    "Owner Email": '',
    'Customer Name': '',
    "Customer Email": '',
  };
  bool click = true;
  String distance = 'Loading...';
  GeoPoint? userLocation;
  bool? isSub = false;
  DateTime? expireDate;
  List<Review> reviews = [];
  Review? userReview;
  List subsGyms = [];
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

  setExpireDate(DateTime startDate) {
    switch (widget.price) {
      case 'One Day':
        setState(() {
          expireDate = startDate.add(const Duration(days: 1));
        });
        break;
      case 'One Month':
        setState(() {
          expireDate = startDate.add(const Duration(days: 30));
        });
        break;
      case 'Three Months':
        setState(() {
          expireDate = startDate.add(const Duration(days: 90));
        });
        break;
      case 'Six Months':
        setState(() {
          expireDate = startDate.add(const Duration(days: 180));
        });
        break;
      case 'One Year':
        setState(() {
          expireDate = startDate.add(const Duration(days: 360));
        });
        break;
      default:
        return '';
    }
  }

  isSubscribed() async {
    var snapshot = FirebaseFirestore.instance
        .collection('Payments')
        .where('customerId', isEqualTo: widget.userid)
        .where('gymId', isEqualTo: widget.gym.gymId)
        .snapshots();

    snapshot.forEach((element) {
      if (element.docs.isEmpty) {
        print(element.docs.length);
        setState(() {
          isSub = false;
        });
      } else {
        setState(() {
          print(element.docs.length);
          isSub = true;
        });
      }
    });
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
            dotHeight: 8,
            dotWidth: 8),
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
              margin: EdgeInsets.only(right: 10, left: 10),
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

                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Container(
                  // margin: EdgeInsets.only(left: 5),
                  // height: 20,
                  // decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.grey),
                  //     borderRadius: BorderRadius.circular(5)),
                  //         child: Row(
                  //           children: [
                  //             gym.priceOneDay != 0
                  //                 ? ElevatedButton(
                  //                     child: Text(
                  //                       'Day',
                  //                       style: TextStyle(
                  //                           color: currentPrice ==
                  //                                   gym.priceOneDay.toString()
                  //                               ? Colors.white
                  //                               : Colors.black,
                  //                           fontSize: 13),
                  //                     ),
                  //                     style: ButtonStyle(
                  //                         shape: MaterialStateProperty.all<
                  //                                 OutlinedBorder>(
                  //                             RoundedRectangleBorder(
                  //                                 side: BorderSide.none)),
                  //                         backgroundColor: currentPrice ==
                  //                                 gym.priceOneDay.toString()
                  //                             ? MaterialStateProperty.all(
                  //                                 Color.fromARGB(
                  //                                     209, 71, 153, 183))
                  //                             : MaterialStateProperty.all(
                  //                                 Colors.white)),
                  //                     onPressed: () {
                  //                       setState(() {
                  //                         currentPrice =
                  //                             gym.priceOneDay.toString();
                  //                       });
                  //                     },
                  //                   )
                  //                 : Container(
                  //                     margin: EdgeInsets.only(left: 10),
                  //                     width: 30,
                  //                     child: Text(
                  //                       'Day',
                  //                       style: TextStyle(color: Colors.grey),
                  //                     ),
                  //                   ),
                  //             gym.priceOneMonth != 0
                  //                 ? ElevatedButton(
                  //                     child: Text(
                  //                       'Month',
                  //                       style: TextStyle(
                  //                           color: currentPrice ==
                  //                                   gym.priceOneMonth.toString()
                  //                               ? Colors.white
                  //                               : Colors.black,
                  //                           fontSize: 13),
                  //                     ),
                  //                     style: ButtonStyle(
                  //                         shape: MaterialStateProperty.all<
                  //                                 OutlinedBorder>(
                  //                             RoundedRectangleBorder(
                  //                                 side: BorderSide.none)),
                  //                         backgroundColor: currentPrice ==
                  //                                 gym.priceOneMonth.toString()
                  //                             ? MaterialStateProperty.all(
                  //                                 Color.fromARGB(
                  //                                     209, 71, 153, 183))
                  //                             : MaterialStateProperty.all(
                  //                                 Colors.white)),
                  //                     onPressed: () {
                  //                       setState(() {
                  //                         currentPrice =
                  //                             gym.priceOneMonth.toString();
                  //                       });
                  //                     },
                  //                   )
                  //                 : Container(
                  //                     margin: EdgeInsets.only(left: 20),
                  //                     width: 50,
                  //                     child: Text(
                  //                       'Month',
                  //                       style: TextStyle(color: Colors.grey),
                  //                     ),
                  //                   ),
                  //             gym.priceThreeMonths != 0
                  //                 ? ElevatedButton(
                  //                     child: Text(
                  //                       '3 Months',
                  //                       style: TextStyle(
                  //                           color: currentPrice ==
                  //                                   gym.priceThreeMonths
                  //                                       .toString()
                  //                               ? Colors.white
                  //                               : Colors.black,
                  //                           fontSize: 13),
                  //                     ),
                  //                     style: ButtonStyle(
                  //                         shape: MaterialStateProperty.all<
                  //                                 OutlinedBorder>(
                  //                             RoundedRectangleBorder(
                  //                                 side: BorderSide.none)),
                  //                         backgroundColor: currentPrice ==
                  //                                 gym.priceThreeMonths
                  //                                     .toString()
                  //                             ? MaterialStateProperty.all(
                  //                                 Color.fromARGB(
                  //                                     209, 71, 153, 183))
                  //                             : MaterialStateProperty.all(
                  //                                 Colors.white)),
                  //                     onPressed: () {
                  //                       setState(() {
                  //                         currentPrice =
                  //                             gym.priceThreeMonths.toString();
                  //                       });
                  //                     },
                  //                   )
                  //                 : Container(
                  //                     margin: EdgeInsets.only(left: 20),
                  //                     width: 80,
                  //                     child: Text(
                  //                       '3 Months',
                  //                       style: TextStyle(color: Colors.grey),
                  //                     ),
                  //                   ),
                  //             gym.priceSixMonths != 0
                  //                 ? ElevatedButton(
                  //                     child: Text(
                  //                       '6 Months',
                  //                       style: TextStyle(
                  //                           color: currentPrice ==
                  //                                   gym.priceSixMonths
                  //                                       .toString()
                  //                               ? Colors.white
                  //                               : Colors.black,
                  //                           fontSize: 13),
                  //                     ),
                  //                     style: ButtonStyle(
                  //                         shape: MaterialStateProperty.all<
                  //                                 OutlinedBorder>(
                  //                             RoundedRectangleBorder(
                  //                                 side: BorderSide.none)),
                  //                         backgroundColor: currentPrice ==
                  //                                 gym.priceSixMonths.toString()
                  //                             ? MaterialStateProperty.all(
                  //                                 Color.fromARGB(
                  //                                     209, 71, 153, 183))
                  //                             : MaterialStateProperty.all(
                  //                                 Colors.white)),
                  //                     onPressed: () {
                  //                       setState(() {
                  //                         currentPrice =
                  //                             gym.priceSixMonths.toString();
                  //                       });
                  //                     },
                  //                   )
                  //                 : Container(
                  //                     margin: EdgeInsets.only(left: 10),
                  //                     width: 80,
                  //                     child: Text(
                  //                       '6 Months',
                  //                       style: TextStyle(color: Colors.grey),
                  //                     ),
                  //                   ),
                  //             gym.priceOneYear != 0
                  //                 ? ElevatedButton(
                  //                     child: Text(
                  //                       'Year',
                  //                       style: TextStyle(
                  // color: currentPrice ==
                  //         gym.priceOneYear.toString()
                  //     ? Colors.white
                  //     : Colors.black,
                  //                           fontSize: 13),
                  //                     ),
                  //                     style: ButtonStyle(
                  //                         shape: MaterialStateProperty.all<
                  //                                 OutlinedBorder>(
                  //                             RoundedRectangleBorder(
                  //                                 side: BorderSide.none)),
                  // backgroundColor: currentPrice ==
                  //         gym.priceOneYear.toString()
                  //     ? MaterialStateProperty.all(
                  //         Color.fromARGB(
                  //             209, 71, 153, 183))
                  //     : MaterialStateProperty.all(
                  //         Colors.white)),
                  //                     onPressed: () {
                  //                       setState(() {
                  //                         currentPrice =
                  //                             gym.priceOneYear.toString();
                  //                       });
                  //                     },
                  //                   )
                  //                 : Container(
                  //                     margin: EdgeInsets.only(left: 20),
                  //                     width: 50,
                  //                     child: Text(
                  //                       'Year',
                  //                       style: TextStyle(color: Colors.grey),
                  //                     ),
                  //                   ),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
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
                                      widget.price = 'One Day';
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
                                      widget.price = 'One Month';
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
                                      widget.price = 'Three Months';
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
                                      widget.price = 'Six Months';
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
                                      widget.price = 'One Year';
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
                                    color: window == 'Facilities'
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
                                      'Facilities',
                                      style: TextStyle(
                                          color: window == 'Facilities'
                                              ? Colors.white
                                              : Colors.black),
                                    ),
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
                color: colors.blue_base,
                width: isSub! ? screenWidth : screenWidth / 2,
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
          if (isSub == false)
            InkWell(
              onTap: widget.price == 'non'
                  ? null
                  : () {
                      print('uid' + widget.userid.toString());
                      print('gymid' + widget.gym.gymId.toString());
                      payform(context, widget.gym.gymId);
                    },
              child: Container(
                  color: widget.price == 'non'
                      ? Colors.grey
                      : Color.fromRGBO(119, 140, 33, 0.984),
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
            )
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
                                    RateFiledValidator.validate(value!);
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
                          //  ? null
                          //       : () {
                          //           setState(() {
                          //             currentPrice =
                          //                 gym.priceOneMonth.toString();
                          //             widget.price = 'One Month';
                          //           });
                          //         },
                          onPressed: () {
                            if (_formKey.currentState!.validate() &&
                                rate != 0.0) {
                              if (comment == '') {
                                Review.addRate(gymid!, rate, widget.userid)
                                    .then((value) => AppUser.message(
                                        bodyctx, true, 'Thank you'))
                                    .onError((error, stackTrace) =>
                                        AppUser.message(
                                            bodyctx, false, error.toString()))
                                    .whenComplete(
                                        () => Review.setRateToGym(gymid));

                                Navigator.pop(context);
                              } else {
                                Review.addReviwe(
                                        gymid!, rate, comment, widget.userid)
                                    .then((value) => AppUser.message(
                                        bodyctx, true, 'Thank you'))
                                    .onError((error, stackTrace) =>
                                        AppUser.message(
                                            bodyctx, false, error.toString()))
                                    .whenComplete(
                                        () => Review.setRateToGym(gymid));

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

  void payform(BuildContext bodyctx, String? gymid) {
    double price = 0.0;
    String comment = '';
    final GlobalKey<FormState> _formKey = GlobalKey();

    showDialog(
        context: bodyctx,
        builder: (BuildContext cxt) {
          return Center(
            child: Container(
              child: AlertDialog(
                  title: Text(
                    "Payment",
                    style: TextStyle(
                        fontFamily: 'Epilogue',
                        fontSize: 18,
                        color: colors.blue_base),
                  ),
                  content: SingleChildScrollView(
                    child: Column(children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              children: [
                                //  Text(
                                //           " ${currentPrice} SAR",
                                //           style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 5, 22, 63)),
                                //         ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 70,
                                  width: 220,
                                  child: TextFormField(
                                      //      initialValue: comment,
                                      maxLength: 16,
                                      obscureText: false,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                        counterText: "",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        contentPadding: EdgeInsets.all(10),
                                        hintText: "Enter Card Number",
                                        hintStyle: TextStyle(
                                          color: colors.hinttext,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.length != 16) {
                                          return '';
                                        }
                                      },
                                      onChanged: (value) {}),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 70,
                                      width: 60,
                                      child: TextFormField(

                                          //  initialValue: comment,
                                          maxLength: 2,
                                          obscureText: false,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          decoration: InputDecoration(
                                            counterText: '',
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            contentPadding: EdgeInsets.all(10),
                                            hintText: "Month",
                                            hintStyle: TextStyle(
                                              color: colors.hinttext,
                                            ),
                                          ),
                                          validator: (value) {
                                            int va = int.parse(value!);
                                            if (va > 12 || value.length > 2) {
                                              return '';
                                            }
                                          },
                                          onChanged: (value) {
                                            // if (value.length == 2) {
                                            // value.padRight(2, '/');
                                            //  value.indexOf(pattern)
                                            // }
                                          }),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('/',
                                        style: TextStyle(
                                            color: colors.black60,
                                            fontSize: 22)),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      height: 70,
                                      width: 60,
                                      child: TextFormField(
                                          //      initialValue: comment,
                                          maxLength: 2,
                                          obscureText: false,
                                          keyboardType: TextInputType.datetime,
                                          decoration: InputDecoration(
                                            counterText: '',
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            contentPadding: EdgeInsets.all(10),
                                            hintText: "Year",
                                            hintStyle: TextStyle(
                                              color: colors.hinttext,
                                            ),
                                          ),
                                          validator: (value) {
                                            int va = int.parse(value!);
                                            if (va < 22 || value.length > 2) {
                                              return '';
                                            }
                                          },
                                          onChanged: (value) {
                                            // if (value.length == 2) {
                                            // value.padRight(2, '/');
                                            //  value.indexOf(pattern)
                                            // }
                                          }),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 70,
                                  width: 60,
                                  child: TextFormField(
                                      //   initialValue: comment,
                                      maxLength: 3,
                                      obscureText: false,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        counterText: '',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        contentPadding: EdgeInsets.all(10),
                                        hintText: "CVV",
                                        hintStyle: TextStyle(
                                          color: colors.hinttext,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.length != 3) {
                                          return '';
                                        }
                                      },
                                      onChanged: (value) {}),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                  actions: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            primary: colors.blue_base,
                            // minimumSize:
                          ),
                          child: const Text(
                            "Pay",
                            style: TextStyle(
                              color: colors.blue_base,
                              fontFamily: 'Roboto',
                              fontSize: 18,
                            ),
                          ),
                          onPressed: widget.price == 'non'
                              ? null
                              : () {
                                  print("The Price" + widget.price);
                                  if (_formKey.currentState!.validate()) {
                                    Navigator.of(context).pop();
                                    setState(() {
                                      click == false;
                                    });
                                    print(widget.gym.gender);
                                    DateTime startDate = DateTime.now();
                                    setExpireDate(startDate);
                                    getInfo().whenComplete(() {
                                      var docId = FirebaseFirestore.instance
                                          .collection('Payments')
                                          .doc();

                                      docId.set({
                                        'ownerName': _data["Owner Name"],
                                        'customerName': _data["Customer Name"],
                                        'ownerId': widget.gym.ownerId,
                                        'gymName': widget.gym.name,
                                        'gymId': widget.gym.gymId,
                                        'customerId': widget.userid,
                                        'price': currentPrice,
                                        'duration': widget.price,
                                        'date': startDate,
                                        'paymentID': docId.id,
                                        'expirationDate': expireDate,
                                      }).whenComplete(() {
                                        AppUser.message(context, true,
                                            'Thank You for you subscription, please check your email');
                                      }).whenComplete(() {
                                        sendOwnerEmail(
                                            customerName:
                                                _data["Customer Name"],
                                            gymName: widget.gym.name!,
                                            ownerEmail: _data["Owner Email"],
                                            ownerName: _data["Owner Name"]);
                                        sendCustomerEmail(
                                          customerName: _data["Customer Name"],
                                          gymName: widget.gym.name!,
                                          customerEmail:
                                              _data["Customer Email"],
                                        );
                                      });
                                    });
                                  } else {
                                    AppUser.message(context, false,
                                        'Check your card information');
                                  }
                                },
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            primary: colors.blue_base,
                            // minimumSize:
                          ),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                              color: colors.red_base,
                              fontFamily: 'Roboto',
                              fontSize: 18,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ]),
            ),
          );
        });
  }

  Future sendCustomerEmail({
    required String customerName,
    required String customerEmail,
    required String gymName,
  }) async {
    final serviceId = 'service_esjrub6';
    final templateId = 'template_0qhl68q';
    final userId = 'wRl-gztCaHY5z6ghO';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'user_name': customerName,
          'user_email': customerEmail,
          'gym_name': gymName,
        }
      }),
    );
    print(response.body);
  }

  Future sendOwnerEmail({
    required String ownerName,
    required String ownerEmail,
    required String customerName,
    required String gymName,
  }) async {
    final serviceId = 'service_esjrub6';
    final templateId = 'template_rb64zcn';
    final userId = 'wRl-gztCaHY5z6ghO';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'user_name': customerName,
          'user_email': ownerEmail,
          'to_name': ownerName,
          'gym_name': gymName,
        }
      }),
    );
    print(response.body);
  }

  Future getInfo() async {
    var owner = await FirebaseFirestore.instance
        .collection('Gym Owner')
        .doc(widget.gym.ownerId)
        .get();
    var customer = await FirebaseFirestore.instance
        .collection('Customer')
        .doc(widget.userid)
        .get();

    Map<String, dynamic> _dataOwner = owner.data() as Map<String, dynamic>;
    Map<String, dynamic> _dataCustomer =
        customer.data() as Map<String, dynamic>;
    _data['Owner Name'] = _dataOwner['name'];
    _data['Owner Email'] = _dataOwner['email'];
    _data['Customer Name'] = _dataCustomer['name'];
    _data['Customer Email'] = _dataCustomer['email'];

    setState(() {});
    print(_data);
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
                Review.setRateToGym(gymid);
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
//  Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child:  Container(
//                       child: Column(
//                         children: [
//                              Row(children: [TextFormField(
//                                 // initialValue: comment,
//                                 // maxLines: null,
//                                 // obscureText: false,

//                             ),],),
//                           currentPrice != ''
//                               ? Row(

//                                 children: [
//                                   Text('Price:', style: TextStyle(fontSize: 22,color: Colors.black)),
//                                   SizedBox(width: 5,),
//                                   Text(
//                                       " ${currentPrice} SAR",
//                                       style: TextStyle(fontSize: 20,color: Colors.black),
//                                     ),
//                                 ],
//                               )
//                               : Text(
//                                   showPrice() + 'Price:',
//                                   style: TextStyle(fontSize: 20, color: Colors.red),
//                                 ),
//                         ],
//                       )),
//                           ),


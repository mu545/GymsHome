import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gymhome/GymOwnerwidgets/gymprice.dart';
import 'package:gymhome/models/GymModel.dart';
import 'package:gymhome/widgets/edit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:gymhome/models/review.dart';
import 'package:gymhome/Styles.dart';
import '../models/user.dart';
import '../widgets/commentCard.dart';

class GymOwnerDescrption extends StatefulWidget {
  GymModel gym;
  //final String userid;
  GymOwnerDescrption({
    Key? key,
    required this.gym,
  }) : super(key: key);
  static const routeName = '/gym';

  @override
  _GymOwnerDescrptionState createState() => _GymOwnerDescrptionState();
}

class _GymOwnerDescrptionState extends State<GymOwnerDescrption> {
//
  // int pricess = 6;
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
            child: CarouselSlider.builder(
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
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildIndicator(),
          SizedBox(
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
                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            '55 Km',
                            style: TextStyle(fontSize: 20),
                          ),
                          Icon(Icons.directions_walk_outlined)
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                gym.avg_rate.toString(),
                                style: TextStyle(fontSize: 30),
                              ),
                              Icon(
                                Icons.star,
                                color: colors.yellow_base,
                              ),
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Text('Based on 320 reviews')),
                        ],
                      ),
                    ],
                  ),
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
                                ? FlatButton(
                                    minWidth: 5,
                                    child: Text(
                                      'Day',
                                      style: TextStyle(
                                          color: currentPrice ==
                                                  gym.priceOneDay.toString()
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 13),
                                    ),
                                    color: currentPrice ==
                                            gym.priceOneDay.toString()
                                        //do this for all
                                        ? Color.fromARGB(195, 71, 153, 183)
                                        : Colors.white,
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
                                ? FlatButton(
                                    minWidth: 5,
                                    child: Text(
                                      'Month',
                                      style: TextStyle(
                                          color: currentPrice ==
                                                  gym.priceOneMonth.toString()
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 13),
                                    ),
                                    color: currentPrice ==
                                            gym.priceOneMonth.toString()
                                        ? Color.fromARGB(195, 71, 153, 183)
                                        : Colors.white,
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
                                ? FlatButton(
                                    minWidth: 5,
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
                                    color: currentPrice ==
                                            gym.priceThreeMonths.toString()
                                        ? Color.fromARGB(195, 71, 153, 183)
                                        : Colors.white,
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
                                ? FlatButton(
                                    minWidth: 5,
                                    child: Text(
                                      '6 Months',
                                      style: TextStyle(
                                          color: currentPrice ==
                                                  gym.priceSixMonths.toString()
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 13),
                                    ),
                                    color: currentPrice ==
                                            gym.priceSixMonths.toString()
                                        ? Color.fromARGB(195, 71, 153, 183)
                                        : Colors.white,
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
                                ? FlatButton(
                                    minWidth: 5,
                                    child: Text(
                                      'Year',
                                      style: TextStyle(
                                          color: currentPrice ==
                                                  gym.priceOneYear.toString()
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 13),
                                    ),
                                    color: currentPrice ==
                                            gym.priceOneYear.toString()
                                        ? Color.fromARGB(195, 71, 153, 183)
                                        : Colors.white,
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
                                  color: window == 'Facilites'
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
                                      'Facilites',
                                      style: TextStyle(
                                        color: window == 'Facilites'
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    )
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
              //DELETE GYM HERE:
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

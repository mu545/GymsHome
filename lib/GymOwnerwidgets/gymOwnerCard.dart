import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GymCard extends StatelessWidget {
  const GymCard({
    Key? key,
    //  required this.isFavorite,
    required this.name,
    required this.imageURL,
    //this.onfavoriteTap,
  }) : super(key: key);

  //final bool isFavorite;
  final String name;
  final String imageURL;
  //final VoidCallback? onfavoriteTap;
  // final String? price;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.35,
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            color: Color(0xff3d4343),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.45),
                offset: Offset(3, 3),
                spreadRadius: 2,
                blurRadius: 2,
              )
            ]),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    )),
                    width: double.infinity,
                    child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                        child: Image.network(imageURL, fit: BoxFit.cover)),
                  ),
                  // Positioned(
                  //   left: 15,
                  //   top: 20,
                  //   child: InkWell(
                  //     onTap: onfavoriteTap,
                  //     child: Icon(
                  //       isFavorite ? Icons.favorite : Icons.favorite_border,
                  //       size: 42,
                  //       color: isFavorite ? Colors.red : Colors.grey,
                  //     ),
                  //   ),
                  // ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius:
                              BorderRadius.only(topRight: Radius.circular(50))),
                      child: Text(
                        name,
                        style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xff48484a),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  )),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        //    price ??
                        "1",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        "330 SAR / m",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Based on 320 reviews",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "50 Km",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.directions_walk,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

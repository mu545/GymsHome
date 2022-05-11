import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymhome/Styles.dart';
import 'package:gymhome/models/profile_model.dart';
import '../models/review.dart';
import '../models/user.dart';

class commentCard extends StatefulWidget {
  final Review review;
  const commentCard({Key? key, required this.review}) : super(key: key);

  @override
  State<commentCard> createState() => _commentCardState();
}

class _commentCardState extends State<commentCard> {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future? _getData() {
    return _fireStore.collection("Customer").doc(widget.review.uid).get();
  }

  ProfileModel _userProfile = ProfileModel('', '', '');
  bool readmore = false;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width - 100;
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
                future: _getData(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    Map<String, dynamic> _data =
                        snapshot.data.data() as Map<String, dynamic>;
                    _userProfile = ProfileModel.fromJson(_data);
                    return ClipOval(
                      child: Image.network(
                        _userProfile.userImage!,
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return CircleAvatar(
                            radius: 25,
                            backgroundColor: colors.blue_smooth,
                            child: Icon(
                              Icons.person,
                              size: 30,
                              color: colors.iconscolor,
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return Text('');
                }),
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
                                  widget.review.name,
                                  style: TextStyle(
                                      color: colors.blue_base, fontSize: 18),
                                )),
                            SizedBox(
                              width: screenWidth / 2,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    for (var i = 0; i < widget.review.rate; i++)
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
                            widget.review.comment,
                            maxLines: readmore ? null : 2,
                            overflow: readmore
                                ? TextOverflow.visible
                                : TextOverflow.fade,
                            style:
                                TextStyle(color: colors.black60, fontSize: 15),
                          ),
                        ),
                      ),
                      if (widget.review.comment.length > 90)
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
            child: Text(widget.review.time.toString()),
          ),
        ),
        Divider(
          color: colors.black60,
        ),
      ]),
    );
  }
}

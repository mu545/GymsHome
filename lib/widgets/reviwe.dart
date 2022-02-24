import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gymhome/Styles.dart';
import 'package:gymhome/models/customer.dart';
import 'package:gymhome/models/user.dart';

//hla milfy
class Reviwes extends StatefulWidget {
  static const routeNamed = '/reviwes';

  @override
  _ReviwesState createState() => _ReviwesState();
}

class _ReviwesState extends State<Reviwes> {
  @override
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, dynamic> _reviwe = {
    'reviews': '',
    'rate': 0.0,
  };

  show() {
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
                                  "Write a review",
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
                                Customer c1 = Customer(name: '');
                                if (_reviwe['reviews'] == '')
                                  c1.addrate(
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
    // final productdata = Provider.of<Comentss>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Add a written review',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Center(
                  child: RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                )
              ],
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.orangeAccent,
              onPressed: () => show(),
              child: Text(
                'Submit',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

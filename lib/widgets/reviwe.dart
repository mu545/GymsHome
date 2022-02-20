import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gymhome/Styles.dart';

class Reviwes extends StatefulWidget {
  static const routeNamed = '/reviwes';

  @override
  _ReviwesState createState() => _ReviwesState();
}

class _ReviwesState extends State<Reviwes> {
  @override
  // var _editfor = Reviewproviser(title: '', description: '');
  int rate = 0;

  final _reviewController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, dynamic> _authData = {
    'reviews': '',
    'rate': 0,
  };

  // void _ShowDialog(String message) {
  //   showDialog(
  //       context: context,
  //       builder: (ctx) => AlertDialog(
  //             title: Text('Add review'),
  //             content: Text(message),
  //             actions: [
  //               // FlatButton(
  //               //     onPressed: () {
  //               //       Navigator.of(ctx).pop();
  //               //     },
  //               //     child: Text('OK'))
  //             ],
  //           ));
  // }

  show() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: AlertDialog(
              content: Container(
                width: MediaQuery.of(context).size.width,
                height: 350,
                child: Column(children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Write a review",
                                style: TextStyle(
                                    fontFamily: 'Epilogue',
                                    fontSize: 18,
                                    color: colors.blue_base),
                              )
                            ]),
                        SizedBox(
                          height: 10,
                        ),
                        RatingBar.builder(
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
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextFormField(
                              maxLines: null,
                              obscureText: false,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                // enabledBorder: OutlineInputBorder(
                                //     //     borderSide: BorderSide(
                                //     //         color: Color.fromARGB(62, 99, 99, 99)),
                                //     //     borderRadius:
                                //     //         BorderRadius.all(Radius.circular(5))),
                                //     // focusedBorder: OutlineInputBorder(
                                //     //     borderSide:
                                //     //         BorderSide(color: colors.blue_base),
                                //     borderRadius:
                                //         BorderRadius.all(Radius.circular(5))),
                                contentPadding: EdgeInsets.all(10),
                                hintText: "review (optional)",
                                hintStyle: TextStyle(
                                  color: colors.hinttext,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty || !value.contains('@'))
                                  return 'Invalid email!';
                              },
                              onChanged: (value) {
                                // email = value;
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            child: Text("Submitß"),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          );
        });
  }

  // Future<void> _showMyDialog() async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Review submitted'),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text('Thanks for your time!'),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text('Ok'),
  //             onPressed: () {
  //               Navigator.of(context).pushNamed('/');
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

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

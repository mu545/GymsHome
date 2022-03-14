import 'package:flutter/material.dart';
import 'package:gymhome/GymOwnerwidgets/location.dart';
import 'package:gymhome/Styles.dart';
import 'package:gymhome/models/gyms.dart';
import 'package:gymhome/provider/gymsitems.dart';
import 'package:gymhome/widgets/AddGym.dart';
import 'package:provider/provider.dart';

class GymPrice extends StatefulWidget {
  static const routenames = '/srsss';
  const GymPrice({Key? key}) : super(key: key);

  @override
  _AddGymState createState() => _AddGymState();
}

class _AddGymState extends State<GymPrice> {
  double? oneDay = 0;
  double? threeMonths = 0;
  double? sixMonths;
  double? oneMonth;
  double? oneYear;
  TextEditingController _dayTEC = TextEditingController();
  TextEditingController _monthTEC = TextEditingController();
  TextEditingController _3monthTEC = TextEditingController();
  TextEditingController _6monthTEC = TextEditingController();
  TextEditingController _yearTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Add Gym ',
          style: TextStyle(color: Colors.white),
        )),
        backgroundColor: colors.blue_base,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              height: 400,
              width: 390,
              child: Card(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text(
                              'Price',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: colors.blue_base,
                                  fontFamily: 'Epilogue'),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                   
                     children: [
                       Container(
                          height: 45,
                          width: 200,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _dayTEC,
                                  decoration: InputDecoration(
                                    hintText: 'Price for one Day',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: colors.black100),
                                    ),
                                  ),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  onSaved: (value) {
                                    //   oneMonth = _monthTEC as double;
                                  },
                                ),
                              ),
                          
                            ],
                          ),
                        ),
                     ],
                   ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 45,
                          width: 200,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _monthTEC,
                                  decoration: InputDecoration(
                                    hintText: 'Price for one Month',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: colors.black100),
                                    ),
                                  ),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  onSaved: (value) {
                                    //   oneMonth = _monthTEC as double;
                                  },
                                ),
                              ),
                           
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                       Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Container(
                          height: 45,
                          width: 200,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _3monthTEC,
                                  decoration: InputDecoration(
                                    hintText: 'Price for Three Months',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: colors.black100),
                                    ),
                                  ),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  onSaved: (value) {
                                    //   oneMonth = _monthTEC as double;
                                  },
                                ),
                              ),
                           
                            ],
                          ),
                        ),
                     ],
                   ),
                    SizedBox(
                      height: 10,
                    ),
                       Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Container(
                          height: 45,
                          width: 200,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _6monthTEC,
                                  decoration: InputDecoration(
                                    hintText: 'Price for Six Months',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: colors.black100),
                                    ),
                                  ),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  onSaved: (value) {
                                    //   oneMonth = _monthTEC as double;
                                  },
                                ),
                              ),
                            
                            ],
                          ),
                        ),
                     ],
                   ),
                    SizedBox(
                      height: 10,
                    ),
                     Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Container(
                          height: 45,
                          width: 200,
                          child: Row(
                              
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _yearTEC,
                                  decoration: InputDecoration(
                                    hintText: 'Price for one Year',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: colors.black100),
                                    ),
                                  ),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  onSaved: (value) {
                                    //   oneMonth = _monthTEC as double;
                                  },
                                ),
                              ),
                            
                            ],
                          ),
                        ),
                    ],
                   ),
                    
                  ],
                ),
              ),
            ),
            Container(
              width: 250,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: colors.blue_base),
              child: FlatButton(
                child: Text(
                  'Send',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  oneDay = double.parse(_dayTEC.text);
                  oneMonth = double.parse(_monthTEC.text);
                  threeMonths = double.parse(_3monthTEC.text);
                  sixMonths = double.parse(_6monthTEC.text);
                  oneYear = double.parse(_yearTEC.text);

                  Provider.of<AddGymMethods>(context, listen: false).addPrices(
                      oneDay, oneMonth, threeMonths, sixMonths, oneYear);
                },
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                textColor: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 250,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: FlatButton(
                child: Text(
                  'Cancel',
                  style: TextStyle(color:colors.blue_base,),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/');
                },
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                textColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color:colors.blue_base, width: 1, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(50)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

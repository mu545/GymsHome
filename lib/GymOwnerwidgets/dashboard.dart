import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:gymhome/Styles.dart';

import '../models/GymModel.dart';

class Dashboard extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  String ownerid;
  List<GymModel> gymsList;
  Dashboard({required this.gymsList, required this.ownerid, Key? key})
      : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    _getdata().whenComplete(() {
      setState(() {
        isloading = false;
      });
    });
    super.initState();
  }

  Future _getdata() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("Payments")
        .where('ownerId', isEqualTo: widget.ownerid)
        .get();

    if (snapshot.size != 0) {
      widget.gymsList.forEach((gym) {
        int count = 0;
        snapshot.docs.forEach((element) {
          Map<String, dynamic> _data = element.data() as Map<String, dynamic>;

          if (_data['gymId'] == gym.gymId) {
            count++;
          }
        });
        data.add(_Data(gym.name!, count));
      });
    }
  }

  bool isloading = true;
  List<_Data> data = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Statistics',
            style: TextStyle(color: Colors.white, fontFamily: 'Epilogue'),
          ),
          backgroundColor: colors.blue_base,
        ),
        body: (!isloading)
            ? (widget.gymsList.isNotEmpty)
                ? SingleChildScrollView(
                    child: Column(children: [
                    SizedBox(
                      height: 30,
                    ),
                    // Initialize the chart widget
                    SfCartesianChart(
                        title: ChartTitle(text: 'Number of subscriptions'),
                        primaryXAxis: CategoryAxis(),
                        // primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <ChartSeries<_Data, String>>[
                          ColumnSeries<_Data, String>(
                              dataSource: data,
                              xValueMapper: (_Data data, _) => data.name,
                              yValueMapper: (_Data data, _) => data.number,
                              // name: 'Gold',
                              color: colors.yellow_base)
                        ]),
                    SfCircularChart(
                      tooltipBehavior: TooltipBehavior(enable: true),
                      // ignore: prefer_const_literals_to_create_immutables
                      series: [
                        // DoughnutSeries<_Data, String>(
                        //   dataSource: data,
                        //   xValueMapper: (_Data data, _) => data.name,
                        //   yValueMapper: (_Data data, _) => data.number,
                        //   dataLabelSettings: DataLabelSettings(isVisible: true),
                        //   dataLabelMapper: (_Data data, _) => data.name,
                        // )

// --------------------------------------------------------------------------------------------------------------

                        PieSeries<_Data, String>(
                          dataSource: data,
                          xValueMapper: (_Data data, _) => data.name,
                          yValueMapper: (_Data data, _) => data.number,
                          dataLabelSettings: DataLabelSettings(
                              isVisible: true,
                              labelPosition: ChartDataLabelPosition.outside),
                          dataLabelMapper: (_Data data, _) => data.name,

                          // name: 'Gold',
                        )

                        // RadialBarSeries<_Data, String>(
                        //   dataSource: data,
                        //   xValueMapper: (_Data data, _) => data.name,
                        //   yValueMapper: (_Data data, _) => data.number,
                        //   dataLabelSettings: DataLabelSettings(
                        //       isVisible: true,
                        //       labelPosition: ChartDataLabelPosition.outside),
                        //   dataLabelMapper: (_Data data, _) => data.name,
                        // )
                      ],
                    ),

                    // widget.gymsList.length >= 2
                    //     ? SfCartesianChart(
                    //         primaryXAxis: CategoryAxis(),
                    //         tooltipBehavior: TooltipBehavior(enable: true),
                    //         series: <ChartSeries<_Data, String>>[
                    //             LineSeries<_Data, String>(
                    //               color: colors.green_base,
                    //               dataSource: data,
                    //               xValueMapper: (_Data sales, _) => sales.name,
                    //               yValueMapper: (_Data sales, _) =>
                    //                   sales.number,
                    //               // name: 'Sales',
                    //               // Enable data label
                    //               // dataLabelSettings:
                    //               // DataLabelSettings(isVisible: true),
                    //             )
                    //           ])
                    //     : Text(''),
                  ]))
                : SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                    child: Center(child: Text('No gyms yet')))
            : loading());
    // :Text('No gyms yet')
  }

  Widget loading() {
    return (SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2,
        child: Center(child: CircularProgressIndicator())));
  }
}

class _Data {
  _Data(this.name, this.number);

  final String name;
  final int number;

  // factory _Data.fromjson(Map<String, dynamic> data) {
  //   return _Data(data[''], data['']);
  // }
}

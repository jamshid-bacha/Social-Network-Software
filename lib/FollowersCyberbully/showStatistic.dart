// import 'package:flutter/material.dart';

// class followerStatistic extends StatefulWidget {
//   String messageText;
//   int fuck;
//   int shit;
//   int asshole;
//   int motherfucker;
//   int bitch;
//   followerStatistic(
//       {Key? key,
//       required this.messageText,
//       required this.fuck,
//       required this.shit,
//       required this.bitch,
//       required this.asshole,
//       required this.motherfucker})
//       : super(key: key);
//   @override
//   _followerStatistic createState() => _followerStatistic();
// }

// class _followerStatistic extends State<followerStatistic> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: WillPopScope(
//         onWillPop: () async {
//           Navigator.pop(context, false);
//           return Future(() => false);
//         },
//         child: Column(
//           children: [
//             Text('This is mmeeee' + widget.messageText),
//             Text('Fuck ${widget.fuck}'),
//             Text('Bitch ${widget.bitch}'),
//             Text('Shit ${widget.shit}'),
//             Text('Asshole ${widget.asshole}'),
//             Text('Mother Fucker ${widget.motherfucker}'),
//           ],
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class followerStatistic extends StatefulWidget {
  static const String id = "followerStatistic";
  String messageText;
  int fuck;
  int shit;
  int asshole;
  int motherfucker;
  int bitch;
  followerStatistic(
      {Key? key,
      required this.messageText,
      required this.fuck,
      required this.shit,
      required this.bitch,
      required this.asshole,
      required this.motherfucker})
      : super(key: key);
  @override
  _followerStatistic createState() => _followerStatistic();
}

class _followerStatistic extends State<followerStatistic> {
  List<ChartData> data = [];

  @override
  void initState() {
    data = [
      ChartData('Fuck', widget.fuck.toDouble()),
      ChartData('Bitch', widget.bitch.toDouble()),
      ChartData('Shit', widget.shit.toDouble()),
      ChartData('Asshole', widget.asshole.toDouble()),
      ChartData('Motherfucker', widget.motherfucker.toDouble())
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          title: const Text('Tweets Analysis'),
        ),
        body: Column(children: [
          //Initialize the chart widget
          SfCartesianChart(
              enableAxisAnimation: true,
              primaryXAxis: CategoryAxis(labelRotation: 90),
              // Chart title
              title: ChartTitle(
                  text: widget.messageText,
                  textStyle: const TextStyle(color: Colors.blue)),
              // Enable legend
              legend: Legend(isVisible: true),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<ChartData, String>>[
                LineSeries<ChartData, String>(
                    dataSource: data,
                    xValueMapper: (ChartData sales, _) => sales.x,
                    yValueMapper: (ChartData sales, _) => sales.y,
                    name: 'Badwords',
                    // Enable data label
                    dataLabelSettings: const DataLabelSettings(isVisible: true))
              ]),
          SfCartesianChart(
              primaryXAxis: CategoryAxis(
                maximumLabelWidth: 80,
              ),
              series: <ChartSeries<ChartData, String>>[
                BarSeries<ChartData, String>(
                    dataSource: data,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y),
              ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                  shadowColor: Colors.greenAccent,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: Size(100, 40), //////// HERE
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Back'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  onPrimary: Colors.white,
                  shadowColor: Colors.greenAccent,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: const Size(100, 40), //////// HERE
                ),
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Confirmation'),
                        content: const Text('Are you sure to unfriend?'),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('No'),
                          ),
                          FlatButton(
                            onPressed: () {
                              // dismisses only the dialog and returns true
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Unfriend'),
              )
            ],
          ),
        ]));
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}

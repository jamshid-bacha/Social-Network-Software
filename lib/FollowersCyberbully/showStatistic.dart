import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'dart:async';
import 'package:twitter_api_v2/twitter_api_v2.dart' as v2;
import 'package:http/http.dart' as http;

class followerStatistic extends StatefulWidget {
  static const String id = "followerStatistic";
  String messageText;
  int fuck;
  int shit;
  int asshole;
  int motherfucker;
  int bitch;
  String tweet_usr_id;
  var userid;
  followerStatistic(
      {Key? key,
      required this.messageText,
      required this.fuck,
      required this.shit,
      required this.bitch,
      required this.asshole,
      required this.motherfucker,
      required this.tweet_usr_id,
      required this.userid})
      : super(key: key);
  @override
  _followerStatistic createState() => _followerStatistic();
}

class _followerStatistic extends State<followerStatistic> {
  final twitter = v2.TwitterApi(
    bearerToken:
        'xxxxxxxx',
    oauthTokens: v2.OAuthTokens(
      consumerKey: 'xxxxx',
      consumerSecret: 'xx',
      accessToken: 'xxx-xxx',
      accessTokenSecret: 'xxxx',
    ),
    retryConfig: v2.RetryConfig.regularIntervals(
      maxAttempts: 5,
      intervalInSeconds: 3,
    ),

    //! The default timeout is 10 seconds.
    timeout: Duration(seconds: 20),
  );

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
    if (kDebugMode) {
      print(widget.tweet_usr_id);
      print(widget.userid);
    }

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
                            onPressed: () async {
                              // dismisses only the dialog and returns true
                              try {
                                final filteredStream =
                                    await twitter.usersService.destroyFollow(
                                        userId: widget.userid,
                                        targetUserId: widget.tweet_usr_id);
                                var url =
                                    "http://192.168.0.26:8000/deleteBadFollower";
                                final http.Response response = await http.post(
                                  Uri.parse(url),
                                  headers: <String, String>{
                                    'Content-Type':
                                        'application/json; charset=UTF-8',
                                  },
                                  body: jsonEncode(<String, String>{
                                    'userID': widget.userid,
                                    'followerID': widget.tweet_usr_id
                                  }),
                                );
                                var parse = jsonDecode(response.body);
                                if (response.statusCode == 200) {
                                  if (kDebugMode) {
                                    print(parse["msg"]);
                                  }
                                }
                              } on TimeoutException catch (e) {
                                if (kDebugMode) {
                                  print(e);
                                }
                              } on v2.UnauthorizedException catch (e) {
                                if (kDebugMode) {
                                  print(e);
                                }
                              } on v2.RateLimitExceededException catch (e) {
                                if (kDebugMode) {
                                  print(e);
                                }
                              } on v2.TwitterException catch (e) {
                                if (kDebugMode) {
                                  print(e.response.headers);
                                  print(e.body);
                                  print(e);
                                }
                              }
                              Navigator.of(context).pop();
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

import 'package:flutter/material.dart';
import 'package:snapp4/FollowersCyberbully/showStatistic.dart';

class ShowList extends StatefulWidget {
  String followerUser_name;
  int fuck;
  int shit;
  int asshole;
  int motherfucker;
  int bitch;
  String imageUrl;
  String total_badWordsUsed;
  bool isMessageRead;
  String location;
  String latitude;
  String longitude;
  String tweet_usr_id;
  String profile_image_url_https;
  var userid;
  ShowList(
      {Key? key,
      required this.followerUser_name,
      required this.imageUrl,
      required this.total_badWordsUsed,
      required this.isMessageRead,
      required this.fuck,
      required this.shit,
      required this.bitch,
      required this.asshole,
      required this.motherfucker,
      required this.location,
      required this.latitude,
      required this.longitude,
      required this.tweet_usr_id,
      required this.profile_image_url_https,
      required this.userid})
      : super(key: key);
  @override
  _ShowList createState() => _ShowList();
}

class _ShowList extends State<ShowList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(widget.profile_image_url_https),
                    maxRadius: 30,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.followerUser_name,
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          FlatButton(
                              onPressed: () async => {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => followerStatistic(
                                              messageText:
                                                  "Analysis of bad words of ${widget.followerUser_name}",
                                              fuck: widget.fuck,
                                              bitch: widget.bitch,
                                              shit: widget.shit,
                                              asshole: widget.asshole,
                                              motherfucker: widget.motherfucker,
                                              tweet_usr_id: widget.tweet_usr_id,
                                              userid: widget.userid)),
                                    )
                                  },
                              child: const Text('Check Statistics')),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              widget.total_badWordsUsed,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: widget.isMessageRead
                      ? FontWeight.bold
                      : FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}

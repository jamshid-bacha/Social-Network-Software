// ignore_for_file: file_names

import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphview/GraphView.dart';
import 'package:snapp4/screens/twitterDrawerList.dart';
import 'ShowList.dart';
import 'dart:io' show Platform, exit;

// ignore: must_be_immutable
class FollowersCyberbully extends StatefulWidget {
  final displayName;
  final photoURL;
  var username;
  var following;
  var followers;
  var dataFromServer;
  var userid;
  FollowersCyberbully(
      // ignore: non_constant_identifier_names
      {Key? key,
      required this.displayName,
      required this.photoURL,
      required this.username,
      required this.following,
      required this.followers,
      required this.dataFromServer,
      required this.userid})
      : super(key: key);
  @override
  _FollowersCyberbully createState() => _FollowersCyberbully();
}

class _FollowersCyberbully extends State<FollowersCyberbully> {
  @override
  Widget build(BuildContext context) {
    var edges = widget.dataFromServer['edges'];
    if (kDebugMode) {
      print("00000000000000000000000000000000000000000000000000000");
      print(edges.length);
      print(edges);
    }

    return Scaffold(
      appBar: AppBar(
          title: const Text("H-SN App"),
          leading: GestureDetector(
            onTap: () async {
              Navigator.pop(context, false);
              return Future(() => false);
            },
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(200)),
                      child: Image.network(
                        widget.photoURL,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0.0),
      drawer: Drawer(
        child: ListView(
          children: [
            TwitterDrawerHeader(
                Displayname: widget.displayName,
                ProfileImage: widget.photoURL,
                username: widget.username,
                following: widget.following,
                follower: widget.followers),
            const Divider(),
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(
                    Icons.account_circle_rounded,
                    color: Colors.blueAccent,
                  ),
                ),
                Padding(padding: EdgeInsets.all(12.0), child: Text("Profile"))
              ],
            ),
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(
                    Icons.list_alt,
                    color: Colors.blueAccent,
                  ),
                ),
                Padding(padding: EdgeInsets.all(12.0), child: Text("Lists"))
              ],
            ),
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(
                    Icons.topic,
                    color: Colors.blueAccent,
                  ),
                ),
                Padding(padding: EdgeInsets.all(12.0), child: Text("Topics"))
              ],
            ),
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(
                    Icons.bookmark,
                    color: Colors.blueAccent,
                  ),
                ),
                Padding(padding: EdgeInsets.all(12.0), child: Text("Bookmark"))
              ],
            ),
            const Divider(),
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(
                    Icons.ads_click,
                    color: Colors.blueAccent,
                  ),
                ),
                Padding(padding: EdgeInsets.all(12.0), child: Text("HSN Ads"))
              ],
            ),
            const Divider(),
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(
                    Icons.computer_rounded,
                    color: Colors.blueAccent,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(12.0), child: Text("Configuration"))
              ],
            ),
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(
                    Icons.help_center_rounded,
                    color: Colors.blueAccent,
                  ),
                ),
                Padding(padding: EdgeInsets.all(12.0), child: Text("Help Desk"))
              ],
            ),
            const Expanded(
                // flex: 70,
                child: Align(
              alignment: Alignment.bottomCenter,
              heightFactor: 9,
              child: Divider(),
            )),
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(
                    Icons.light_mode_outlined,
                    color: Colors.blueAccent,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(12.0), child: Text("Night Mode"))
              ],
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: ListView.builder(
          itemCount: edges.length,
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 16),
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return ShowList(
              followerUser_name: edges![index]['followerUsername'].toString(),
              fuck: edges![index]['fuck'],
              bitch: edges![index]['bitch'],
              shit: edges![index]['shit'],
              asshole: edges![index]['asshole'],
              motherfucker: edges![index]['motherfucker'],
              imageUrl: edges![index]['imageURl'].toString(),
              total_badWordsUsed: edges![index]['total_badWords'].toString(),
              location: edges![index]['location'],
              latitude: edges![index]['latitude'],
              longitude: edges![index]['longitude'],
              tweet_usr_id: edges![index]['tweet_usr_id'],
              profile_image_url_https: edges![index]['profile_image_url_https'],
              userid: widget.userid,
              isMessageRead: (index == 0 || index == 3) ? true : false,
            );
          },
        ),
      ),
    );
  }
}

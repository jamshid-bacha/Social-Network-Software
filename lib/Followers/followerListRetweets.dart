// ignore_for_file: file_names

import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

import '../screens/twitterDrawerList.dart';
import 'ShowList.dart';

class FollowerListRetweets extends StatefulWidget {
  final displayName;
  final photoURL;
  var username;
  var following;
  var followers;
  var dataFromServer;
  FollowerListRetweets(
      // ignore: non_constant_identifier_names
      {Key? key,
      required this.displayName,
      required this.photoURL,
      required this.username,
      required this.following,
      required this.followers,
      required this.dataFromServer})
      : super(key: key);
  @override
  _FollowerListRetweets createState() => _FollowerListRetweets();
}

class _FollowerListRetweets extends State<FollowerListRetweets> {
  @override
  Widget build(BuildContext context) {
    var edges = widget.dataFromServer['edges'];
    if (kDebugMode) {
      print("00000000000000000000000000000000000000000000000000000");
      print(edges.length);
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
              name: edges![index]['to'].toString(),
              messageText: "",
              imageUrl: edges![index]['imageURl'].toString(),
              time: edges![index]['strokeWidth'].toString(),
              isMessageRead: (index == 0 || index == 3) ? true : false,
            );
          },
        ),
      ),
    );
  }
}

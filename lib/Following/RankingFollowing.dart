// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../screens/WelcomeApp.dart';
import '../screens/twitterDrawerList.dart';
import 'package:http/http.dart' as http;

import 'followingsListLikes.dart';
import 'followingsListMention.dart';
import 'followingsListReply.dart';
import 'followingsListRetweets.dart';

class RankingFollowing extends StatefulWidget {
  final String displayName;
  final String photoURL;
  final String username;
  final int following;
  final int followers;
  final String id;
  final String time_zone;
  final String favourites_count;
  final String msg;
  const RankingFollowing(
      {Key? key,
      required this.displayName,
      required this.photoURL,
      required this.username,
      required this.id,
      required this.following,
      required this.followers,
      required this.favourites_count,
      required this.time_zone,
      required this.msg})
      : super(key: key);
  @override
  _RankingFollowing createState() => _RankingFollowing();
}

class _RankingFollowing extends State<RankingFollowing> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

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
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, false);
          return Future(() => false);
        },
        child: Stack(
          children: <Widget>[
            // Image.asset(
            //   'assets/background.jpg',
            //   fit: BoxFit.fill,
            //   height: double.infinity,
            //   width: double.infinity,
            // ),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.topRight,
                      colors: [
                    Colors.black.withOpacity(.9),
                    Colors.black.withOpacity(.1),
                  ])),
            ),
            Builder(builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: ClipRRect(
                    //     borderRadius:
                    //         const BorderRadius.all(Radius.circular(200)),
                    //     child: Image.network(
                    //       widget.photoURL,
                    //     ),
                    //   ),
                    // ),
                    Text(
                      widget.msg,
                      style: const TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Name: ${widget.displayName}',
                      style: const TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Username: ${widget.username}',
                      style: const TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Following: ${widget.following}',
                      style: const TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Followers: ${widget.followers}',
                      style: const TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                    ),
                    // Text(
                    //   'Id: ${widget.id}',
                    //   style: const TextStyle(
                    //     fontSize: 15.0,
                    //     color: Colors.white,
                    //   ),
                    // ),
                    // Text(
                    //   'Favourites Count: ${widget.favourites_count}',
                    //   style: const TextStyle(
                    //     fontSize: 15.0,
                    //     color: Colors.white,
                    //   ),
                    // ),
                    // Text(
                    //   'Time Zone: ${widget.time_zone}',
                    //   style: const TextStyle(
                    //     fontSize: 15.0,
                    //     color: Colors.white,
                    //   ),
                    // ),

                    const Text(
                      //'Welcome to H-SNApp',
                      '',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    InkWell(
                      onTap: () async {
                        final response = await http.get(Uri.parse(
                            'http://192.168.0.26:8000/rankbyretweets'));
                        if (response.statusCode == 200) {
                          var parse = jsonDecode(response.body);
                          if (kDebugMode) {
                            print(parse['msg']);
                          }
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FollowingsListRetweets(
                                      displayName: widget.displayName,
                                      photoURL: widget.photoURL,
                                      username: widget.username,
                                      following: widget.following,
                                      followers: widget.followers,
                                      dataFromServer: parse['msg'],
                                    )),
                          );
                        }
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(50)),
                        margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: const Center(
                            child: Text(
                          'Rank Followers by Retweets',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        final response = await http.get(Uri.parse(
                            'http://192.168.0.26:8000/RankingByLikesServer'));
                        if (response.statusCode == 200) {
                          var parse = jsonDecode(response.body);
                          if (kDebugMode) {
                            print(parse);
                          }
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FollowingsListLikes(
                                    displayName: widget.displayName,
                                    photoURL: widget.photoURL,
                                    username: widget.username,
                                    following: widget.following,
                                    followers: widget.followers,
                                    dataFromServer: parse['msg'])),
                          );
                        }
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(50)),
                        margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: const Center(
                            child: Text(
                          'Rank Followers by Likes',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        final response = await http.get(Uri.parse(
                            'http://192.168.0.26:8000/RankingByReplyServer'));
                        if (response.statusCode == 200) {
                          var parse = jsonDecode(response.body);
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FollowingsListReply(
                                      displayName: widget.displayName,
                                      photoURL: widget.photoURL,
                                      username: widget.username,
                                      following: widget.following,
                                      followers: widget.followers,
                                      dataFromServer: parse['msg'],
                                    )),
                          );
                        }
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(50)),
                        margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: const Center(
                            child: Text(
                          'Rank Followers by Reply',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        final response = await http.get(Uri.parse(
                            'http://192.168.0.26:8000/RankingBymentionServer'));
                        if (response.statusCode == 200) {
                          var parse = jsonDecode(response.body);
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FollowingsListMention(
                                      displayName: widget.displayName,
                                      photoURL: widget.photoURL,
                                      username: widget.username,
                                      following: widget.following,
                                      followers: widget.followers,
                                      dataFromServer: parse['msg'],
                                    )),
                          );
                        }
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(50)),
                        margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: const Center(
                            child: Text(
                          'Rank Followers by Mention',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SignInOrRegister(result: false)),
                        );
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(50)),
                        margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: const Center(
                            child: Text(
                          'Logout',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
                      ),
                    ),
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}

fetchDatafromServer() async {
  final response =
      await http.get(Uri.parse('http://192.168.0.26:8000/getData'));
  if (response.statusCode == 200) {
    var parse = jsonDecode(response.body);
    if (kDebugMode) {
      print(parse["msg"]);
    }
    return true;
  } else {
    throw Exception('Failed to load album');
    // ignore: dead_code
    return false;
  }
}

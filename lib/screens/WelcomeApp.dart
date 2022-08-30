// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snapp4/screens/linkedInLogin.dart';
import 'package:snapp4/screens/youtubelog.dart';
import 'package:twitter_login/schemes/access_token.dart';
import 'login.dart';
import 'register.dart';
import 'package:twitter_login/twitter_login.dart';
import 'WelcomeTwitter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform, exit;

class SignInOrRegister extends StatefulWidget {
  const SignInOrRegister({Key? key, required bool result}) : super(key: key);
  @override
  _SignInOrRegisterState createState() => _SignInOrRegisterState();
}

class _SignInOrRegisterState extends State<SignInOrRegister> {
  bool isLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  // ignore: non_constant_identifier_names
  DateTime pre_backpress = DateTime.now();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? WillPopScope(
            onWillPop: () async {
              final timegap = DateTime.now().difference(pre_backpress);
              final cantExit = timegap >= const Duration(seconds: 2);
              pre_backpress = DateTime.now();
              if (cantExit) {
                const snack = SnackBar(
                  content: Text('Press Back button again to Exit'),
                  duration: Duration(seconds: 2),
                );
                ScaffoldMessenger.of(context).showSnackBar(snack);
                return false;
              } else {
                return true;
              }
            },
            child: Scaffold(
              appBar: AppBar(
                  title: const Text("H-SN App"),
                  actions: <Widget>[
                    IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ],
                  leading: GestureDetector(
                    onTap: () {
                      if (Platform.isAndroid) {
                        SystemNavigator.pop();
                      } else if (Platform.isIOS) {
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          SystemChannels.platform
                              .invokeMethod('SystemNavigator.pop');
                        });
                      }
                    },
                    child: const Icon(
                      Icons.arrow_back,
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0.0),
              resizeToAvoidBottomInset: false,
              extendBodyBehindAppBar: true,
              body: Stack(
                children: <Widget>[
                  Image.asset(
                    'assets/background.jpg',
                    fit: BoxFit.fill,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
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
                          const Text(
                            'Welcome to',
                            style: TextStyle(
                              fontSize: 27.0,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          const Text(
                            'SNApp',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          // InkWell(
                          //   onTap: () {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => Login()),
                          //     );
                          //   },
                          //   child: Container(
                          //     height: 50,
                          //     decoration: BoxDecoration(
                          //         border: Border.all(color: Colors.white),
                          //         borderRadius: BorderRadius.circular(50)),
                          //     margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                          //     child: const Center(
                          //         child: Text(
                          //       'Login',
                          //       style: TextStyle(
                          //           fontSize: 16, color: Colors.white),
                          //     )),
                          //   ),
                          // ),
                          InkWell(
                            onTap: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                              );
                            },
                            child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(50)),
                                margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Icon(
                                        Icons.account_box,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(left: 60.0),
                                        child: Text(
                                          "User Login",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ))
                                  ],
                                )),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () async {
                              await logintwitter();
                            },
                            child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(50)),
                                margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Icon(
                                        FontAwesomeIcons.twitter,
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(left: 60.0),
                                        child: Text(
                                          "Twitter Login",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ))
                                  ],
                                )),
                          ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          // InkWell(
                          //   onTap: () async {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => YouTubeLogin()),
                          //     );
                          //   },
                          //   child: Container(
                          //       height: 50,
                          //       decoration: BoxDecoration(
                          //           border: Border.all(color: Colors.white),
                          //           borderRadius: BorderRadius.circular(50)),
                          //       margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                          //       child: Row(
                          //         mainAxisAlignment: MainAxisAlignment.start,
                          //         children: const [
                          //           Padding(
                          //             padding: EdgeInsets.all(12.0),
                          //             child: Icon(
                          //               FontAwesomeIcons.youtube,
                          //               color: Colors.red,
                          //             ),
                          //           ),
                          //           Padding(
                          //               padding: EdgeInsets.only(left: 60.0),
                          //               child: Text(
                          //                 "YouTube Login",
                          //                 style: TextStyle(
                          //                     fontSize: 16,
                          //                     color: Colors.white),
                          //               ))
                          //         ],
                          //       )),
                          // ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          // InkWell(
                          //   onTap: () async {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) =>
                          //               const LinkedInProfileExamplePage()),
                          //     );
                          //   },
                          //   child: Container(
                          //       height: 50,
                          //       decoration: BoxDecoration(
                          //           border: Border.all(color: Colors.white),
                          //           borderRadius: BorderRadius.circular(50)),
                          //       margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                          //       child: Row(
                          //         mainAxisAlignment: MainAxisAlignment.start,
                          //         children: const [
                          //           Padding(
                          //             padding: EdgeInsets.all(12.0),
                          //             child: Icon(
                          //               FontAwesomeIcons.linkedin,
                          //               color: Colors.blue,
                          //             ),
                          //           ),
                          //           Padding(
                          //               padding: EdgeInsets.only(left: 60.0),
                          //               child: Text(
                          //                 "LinkedIn Login",
                          //                 style: TextStyle(
                          //                     fontSize: 16,
                          //                     color: Colors.white),
                          //               ))
                          //         ],
                          //       )),
                          // ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50)),
                            margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                            child: const Center(
                                child: Text(
                              "Don't have an account",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            )),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Register()),
                              );
                            },
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50)),
                              margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                              child: const Center(
                                  child: Text(
                                "Create account",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
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
          )
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: WillPopScope(
                onWillPop: () async {
                  // Navigator.pop(context, false);
                  setState(() {
                    isLoading = false;
                  });
                  return Future(() => false);
                },
                child: Stack(children: <Widget>[
                  // Image.asset(
                  //   'assets/background2.jpg',
                  //   fit: BoxFit.fill,
                  //   height: double.infinity,
                  //   width: double.infinity,
                  // ),
                  Center(

                      //  padding: const EdgeInsets.all(16),
                      // color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.8),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        // Image.asset(
                        //   "assets/twitterbird1.gif",
                        //   height: 100.0,
                        //   width: 100.0,
                        // ),
                      ]))
                ])));
  }

  Future logintwitter() async {
    final twitterLogin = TwitterLogin(
      apiKey: 'xxxx',
      apiSecretKey: 'xxxxx',
      redirectURI: 'example://',
    );
    setState(() {
      isLoading = true;
    });
    await twitterLogin.login().then((value) async {
      // ignore: non_constant_identifier_names
      final TwitterAuthCredential = TwitterAuthProvider.credential(
          accessToken: value.authToken!, secret: value.authTokenSecret!);

      final userCredential =
          await _auth.signInWithCredential(TwitterAuthCredential);
      // sendUserInfoServer(
      //     userCredential.additionalUserInfo!.profile!['id'].toString(),
      //     userCredential.additionalUserInfo!.username.toString());
      // print(userCredential.user!);
      switch (value.status) {
        case TwitterLoginStatus.loggedIn:
          print('====== Login success ======');

          var url = "http://192.168.0.26:8000/twitterlogUserInfo";
          final http.Response response = await http.post(
            Uri.parse(url),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'userID':
                  userCredential.additionalUserInfo!.profile!['id'].toString(),
              'username':
                  userCredential.additionalUserInfo!.username.toString(),
              'displayName': userCredential.user!.displayName.toString(),
              'photoURL': userCredential.user!.photoURL.toString(),
              'friends_count': userCredential
                  .additionalUserInfo!.profile!['friends_count']
                  .toString(),
              'followers_count': userCredential
                  .additionalUserInfo!.profile!['followers_count']
                  .toString(),
              'time_zone': userCredential
                  .additionalUserInfo!.profile!['time_zone']
                  .toString(),
              'favourites_count': userCredential
                  .additionalUserInfo!.profile!['favourites_count']
                  .toString(),
              'verified': userCredential
                  .additionalUserInfo!.profile!['verified']
                  .toString(),
            }),
          );
          var parse = jsonDecode(response.body);
          if (response.statusCode == 200) {
            print(parse["msg"]);
            print(parse["totalFollowr"]);
            bool result = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WelcomeTwitter(
                        msg: parse["msg"],
                        displayName:
                            userCredential.user!.displayName.toString(),
                        photoURL: userCredential.user!.photoURL.toString(),
                        username: userCredential.additionalUserInfo!.username
                            .toString(),
                        id: userCredential.additionalUserInfo!.profile!['id']
                            .toString(),
                        following: userCredential
                            .additionalUserInfo!.profile!['friends_count'],
                        followers: userCredential
                            .additionalUserInfo!.profile!['followers_count'],
                        time_zone: userCredential
                            .additionalUserInfo!.profile!['time_zone']
                            .toString(),
                        favourites_count: userCredential
                            .additionalUserInfo!.profile!['favourites_count']
                            .toString(),
                      )),
            );
            setState(() {
              isLoading = result;
            });
          }
          // var usrName = userCredential.additionalUserInfo!.username.toString();
          // var link = 'http://3.39.102.69:5000/get_user/';
          // var aaaa = link + usrName;
          // print(aaaa);
          // final response = await http.get(Uri.parse(aaaa));
          // // print(response);
          // var parse = jsonDecode(response.body);
          // if (response.statusCode == 200) {
          //   print(userCredential.user);
          //   bool result = await Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => WelcomeTwitter(
          //               msg: "kkk",
          //               displayName:
          //                   userCredential.user!.displayName.toString(),
          //               photoURL: userCredential.user!.photoURL.toString(),
          //               username: userCredential.additionalUserInfo!.username
          //                   .toString(),
          //               id: userCredential.additionalUserInfo!.profile!['id']
          //                   .toString(),
          //               following: userCredential
          //                   .additionalUserInfo!.profile!['friends_count'],
          //               followers: 4,
          //               time_zone: userCredential
          //                   .additionalUserInfo!.profile!['time_zone']
          //                   .toString(),
          //               favourites_count: userCredential
          //                   .additionalUserInfo!.profile!['favourites_count']
          //                   .toString(),
          //             )),
          //   );
          //   setState(() {
          //     isLoading = result;
          //   });
          // } else {
          //   throw Exception('Failed to load album');
          // }
          break;
        case TwitterLoginStatus.cancelledByUser:
          print('====== Login cancel ======');
          break;
        case TwitterLoginStatus.error:
        case null:
          print('====== Login error ======');
          break;
      }
      await FirebaseAuth.instance.signInWithCredential(TwitterAuthCredential);
      print(TwitterAuthCredential);
    });
  }

  Future loginlinkedin() async {}
}

sendUserInfoServer(userid, username) async {
  if (kDebugMode) {
    print(username);
  }
  var url = "http://192.168.0.26:8000/twitterlogUserInfo";
  final http.Response response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'userID': userid,
      'username': username,
    }),
  );
  if (kDebugMode) {
    print(response.body);
  }
}


   // SystemChrome.setSystemUIOverlayStyle(
    //     const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

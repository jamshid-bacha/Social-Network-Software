// ignore: file_names
import 'package:flutter/foundation.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:flutter/material.dart';

const String redirectUrl = 'http://localhost:54307/signin-linkedin';
const String clientId = 'xxx';
const String clientSecret = 'xxx';

class LinkedInProfileExamplePage extends StatefulWidget {
  const LinkedInProfileExamplePage({Key? key}) : super(key: key);

  @override
  State createState() => _LinkedInProfileExamplePageState();
}

class _LinkedInProfileExamplePageState
    extends State<LinkedInProfileExamplePage> {
  late UserObject user = UserObject(
    firstName: "",
    lastName: "",
    email: "",
    profileImageUrl: "",
  );
  bool logoutUser = false;

  @override
  Widget build(BuildContext context) {
    if (!logoutUser) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //   const Text('Login via Linkedin',
          //      style: TextStyle(fontSize: 16, color: Colors.white)),
          ElevatedButton(
            child: const Text('Allow Linkedin'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => LinkedInUserWidget(
                    appBar: AppBar(
                      title: const Text('Login via Linkedin'),
                    ),
                    destroySession: logoutUser,
                    redirectUrl: redirectUrl,
                    clientId: clientId,
                    clientSecret: clientSecret,
                    // ignore: prefer_const_literals_to_create_immutables
                    projection: [
                      ProjectionParameters.id,
                      ProjectionParameters.localizedFirstName,
                      ProjectionParameters.localizedLastName,
                      ProjectionParameters.firstName,
                      ProjectionParameters.lastName,
                      ProjectionParameters.profilePicture,
                    ],
                    onError: (UserFailedAction e) {
                      // if (kDebugMode) {
                      //   print('Error: ${e.toString()}');
                      // }
                      // if (kDebugMode) {
                      //   print('Error: ${e.stackTrace.toString()}');
                      // }
                    },
                    onGetUserProfile: (UserSucceededAction linkedInUser) {
                      // if (kDebugMode) {
                      //   print(
                      //       'Access token ${linkedInUser.user.token.accessToken}');
                      // }

                      // if (kDebugMode) {
                      //   print('User id: ${linkedInUser.user.userId}');
                      // }

                      user = UserObject(
                        firstName:
                            linkedInUser.user.firstName!.localized!.label ?? "",
                        lastName:
                            linkedInUser.user.lastName!.localized!.label ?? "",
                        email: "",
                        profileImageUrl: "",
                      );
                      if (kDebugMode) {
                        print(
                            "qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq");
                        print(linkedInUser.user);
                        print(linkedInUser.user.email);
                      }
                      setState(() {
                        logoutUser = true;
                      });
                      Navigator.pop(context);
                    },
                  ),
                  fullscreenDialog: true,
                ),
              );
            },
          ),
        ],
      );
    } else {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('First name: ${user.firstName} ',
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black)),
                  Text('Last name: ${user.lastName} ',
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black)),
                  // Text('Email: ${user.email}',
                  //     style:
                  //         const TextStyle(fontSize: 16, color: Colors.black)),
                  // Text('Profile image: ${user.profileImageUrl}',
                  //     style:
                  //         const TextStyle(fontSize: 16, color: Colors.black)),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    logoutUser = false;
                    if (kDebugMode) {
                      print(logoutUser);
                    }
                  });
                },
                child: const Text('Logout Linkedin'),
                //  buttonText: 'Logout',
              ),
            ],
          ));
    }
  }
}

class AuthCodeObject {
  AuthCodeObject({required this.code, required this.state});

  String code, state;
}

class UserObject {
  UserObject(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.profileImageUrl});

  String firstName, lastName, email, profileImageUrl;
}

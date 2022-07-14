// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snapp4/screens/login.dart';
import 'package:email_validator/email_validator.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var email;
  var password;
  var phonenumber;
  String _errorMessage = '';
  bool emailformate = false;
  bool validateEmail(String val) {
    if (val.isEmpty) {
      setState(() {
        _errorMessage = "Email can not be empty";
        emailformate = false;
      });
    } else if (!EmailValidator.validate(val, true)) {
      setState(() {
        _errorMessage = "Invalid Email Address";
        emailformate = false;
      });
    } else {
      setState(() {
        _errorMessage = "";
        emailformate = true;
      });
    }
    return emailformate;
  }

  @override
  Widget build(BuildContext context) {
    bool loading = false;

    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return Scaffold(
      appBar: AppBar(
          title: const Text("Register Your Account",
              style: TextStyle(color: Colors.white)),
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
            onTap: () async {
              Navigator.pop(context, false);
              return Future(() => false);
            },
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0),
      // resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      body: WillPopScope(
          onWillPop: () async {
            Navigator.pop(context, false);
            return Future(() => false);
          },
          child: Stack(
            children: <Widget>[
              Image.asset(
                'assets/background.jpg',
                fit: BoxFit.fill,
                height: double.infinity,
                width: double.infinity,
              ),
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                      Colors.black.withOpacity(.9),
                      Colors.black.withOpacity(.1),
                    ])),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 27.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text(
                      'Created by CCRLab',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Stack(
                      children: <Widget>[
                        Container(
                            width: double.infinity,
                            margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(50)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.only(left: 20),
                                  height: 22,
                                  width: 22,
                                  child: const Icon(
                                    Icons.email,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ],
                            )),
                        Container(
                          height: 50,
                          margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                                hintText: 'Email',
                                focusedBorder: InputBorder.none,
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.white70)),
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white),
                            onChanged: (value) {
                              bool a = validateEmail(value);
                              if (a) {
                                email = value;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Stack(
                      children: <Widget>[
                        Container(
                            width: double.infinity,
                            margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(50)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.only(left: 20),
                                  height: 22,
                                  width: 22,
                                  child: const Icon(
                                    Icons.phone,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ],
                            )),
                        Container(
                            height: 50,
                            margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                            child: TextField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  hintText: 'Mobile Number',
                                  focusedBorder: InputBorder.none,
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.white70)),
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white),
                              onChanged: (value) {
                                phonenumber = value;
                              },
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Stack(
                      children: <Widget>[
                        Container(
                            width: double.infinity,
                            margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(50)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.only(left: 20),
                                  height: 22,
                                  width: 22,
                                  child: const Icon(
                                    Icons.vpn_key,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ],
                            )),
                        Container(
                            height: 50,
                            margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                            child: TextField(
                              textAlign: TextAlign.center,
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: const InputDecoration(
                                hintText: 'Password',
                                focusedBorder: InputBorder.none,
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.white70),
                              ),
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white),
                              onChanged: (value) {
                                password = value;
                              },
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _errorMessage,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50)),
                      margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Center(
                          child: FlatButton.icon(
                              onPressed: () async {
                                // await sendInfoServer(
                                //     email, phonenumber, password);
                                var url =
                                    "http://192.168.0.26:8000/AppRegistereScreen";
                                final http.Response response = await http.post(
                                  Uri.parse(url),
                                  headers: <String, String>{
                                    'Content-Type':
                                        'application/json; charset=UTF-8',
                                  },
                                  body: jsonEncode(<String, String>{
                                    'email': email,
                                    'phoneNumber': phonenumber,
                                    'password': password,
                                  }),
                                );
                                var parse = jsonDecode(response.body);
                                if (response.statusCode == 200) {
                                  if (kDebugMode) {
                                    print(parse["msg"]);
                                  }
                                  Navigator.pushNamed(
                                    context,
                                    LandingScreen.id,
                                    //  arguments: {'msg': email},
                                  );
                                }
                              },
                              icon: const Icon(Icons.save),
                              label: const Text("Sign Up"))),
                    ),
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
                        "Already have an account",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      )),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50)),
                        margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: const Center(
                            child: Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

sendInfoServer(email, phone, password) async {
  var url = "http://192.168.0.26:8000/AppRegistereScreen";
  final http.Response response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'phoneNumber': phone,
      'password': password,
    }),
  );
  var parse = jsonDecode(response.body);
  print(parse["msg"]);
  if (parse.statusCode == 200) {
    if (kDebugMode) {
      print(parse["msg"]);
    }
  }
}

class LandingScreen extends StatelessWidget {
  static const String id = "LandingScreen";

  const LandingScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(child: Text("Welcome to H-SN App")),
          FlatButton.icon(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('token', false);
                Navigator.pushNamed(context, Login.id);
              },
              icon: const Icon(Icons.send),
              label: const Text("Logout"))
        ],
      ),
    );
  }
}

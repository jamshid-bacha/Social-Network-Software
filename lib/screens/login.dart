import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'register.dart';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';

class Login extends StatefulWidget {
  static const String id = "Login";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var email;
  var password;
  var wrongInfro = '';
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
    return Scaffold(
      appBar: AppBar(
          title: const Text("Login", style: TextStyle(color: Colors.white)),
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
                //TODO update this
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
              Padding(
                padding: EdgeInsets.only(bottom: 0),
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
                                  margin: EdgeInsets.only(left: 20),
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
                            child: TextField(
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
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50)),
                      margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Center(
                          child: FlatButton.icon(
                              onPressed: () async {
                                // await LogintoServer(email, password);
                                var url =
                                    "http://192.168.0.26:8000/AppLoginScreen";
                                final http.Response response = await http.post(
                                  Uri.parse(url),
                                  headers: <String, String>{
                                    'Content-Type':
                                        'application/json; charset=UTF-8',
                                  },
                                  body: jsonEncode(<String, String>{
                                    'email': email,
                                    'password': password,
                                  }),
                                );
                                var parse = jsonDecode(response.body);
                                if (response.statusCode == 200) {
                                  if (kDebugMode) {
                                    print(parse["msg"]);
                                  }

                                  if (parse["emailvalid"] == true) {
                                    Navigator.pushNamed(
                                        context, LandingScreen.id);
                                  } else {
                                    wrongInfro = parse["msg"];
                                  }
                                }
                              },
                              icon: const Icon(Icons.save),
                              label: const Text("Login"))),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'msg' + wrongInfro,
                        style: const TextStyle(color: Colors.red),
                      ),
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
                        "Don't have an account",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      )),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Register()),
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
              )
            ],
          )),
    );
  }
}

LogintoServer(email, password) async {
  if (kDebugMode) {
    // print(email);
  }
  var url = "http://192.168.0.26:8000/AppLoginScreen";
  final http.Response response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );

  SharedPreferences prefs = await SharedPreferences.getInstance();

  var parse = jsonDecode(response.body);
  if (kDebugMode) {
    // print(parse);
    // print(parse["token"]);
    print(parse["msg"]);
  }
  await prefs.setString('token', parse["token"]);
  String? token = prefs.getString("token");
  if (kDebugMode) {
    print(token);
  }
}

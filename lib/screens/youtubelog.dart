import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:googleapis/youtube/v3.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: 'xxxx',
  scopes: <String>[
    'email',
    'xxxx',
  ],
);

class YouTubeLogin extends StatefulWidget {
  const YouTubeLogin({Key? key}) : super(key: key);

  @override
  State createState() => YouTubeLoginState();
}

class YouTubeLoginState extends State<YouTubeLogin> {
  GoogleSignInAccount? _currentUser;
  String _contactText = '';

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleGetContact(_currentUser!);
      }
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    setState(() {
      _contactText = 'Loading contact info...';
    });
    final http.Response response = await http.get(
      Uri.parse('xxxx'),
      headers: await user.authHeaders,
    );

    final http.Response response2 = await http.get(
      Uri.parse(
          'xxxx'),
      headers: await user.authHeaders,
    );
    print('xxxxx');
    final Map<String, dynamic> data2 =
        json.decode(response.body) as Map<String, dynamic>;

    final String? namedContact2 = _pickFirstNamedContact(data2);

    if (response.statusCode != 200) {
      setState(() {
        _contactText = 'People API gave a ${response.statusCode} '
            'response. Check logs for details.';
      });
      // print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;

    final String? namedContact = _pickFirstNamedContact(data);

    setState(() {
      if (namedContact != null) {
        _contactText = 'I see you know $namedContact';
      } else {
        _contactText = 'No contacts to display.';
      }
    });
  }

  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;

    final Map<String, dynamic>? contact = connections?.firstWhere(
      (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if (contact != null) {
      final Map<String, dynamic>? name = contact['names'].firstWhere(
        (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>?;
      if (name != null) {
        if (kDebugMode) {
          print('wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww');
          print(name['displayName'].toString());
        }
        return name['displayName'] as String?;
      }
    }
    return null;
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      //  print(error);
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.signOut();

  bool logout = true;
  Widget _buildBody() {
    final GoogleSignInAccount? user = _currentUser;
    if (user != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(user.displayName.toString()),
          Text(user.email.toString()),
          Text(user.id.toString()),

          const Text('Signed in successfully.'),
          // Text(_contactText),
          ElevatedButton(
            child: const Text('Sign out'),
            onPressed: _handleSignOut,
          ),
          // ElevatedButton(
          //   child: const Text('REFRESH'),
          //   onPressed: () => _handleGetContact(user),
          // ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text('You are not currently signed in.'),
          ElevatedButton(
            child: const Text('Allow app'),
            onPressed: _handleSignIn,
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('YouTube Sign In'),
        ),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: _buildBody(),
        ));
  }
}

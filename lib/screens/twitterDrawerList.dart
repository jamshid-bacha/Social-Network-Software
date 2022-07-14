// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class TwitterDrawerHeader extends StatefulWidget {
  final String Displayname;
  final String ProfileImage;
  final String username;
  final int following;
  final int follower;
  const TwitterDrawerHeader(
      {Key? key,
      required this.Displayname,
      required this.ProfileImage,
      required this.username,
      required this.following,
      required this.follower})
      : super(key: key);

  @override
  _TwitterDrawerHeader createState() => _TwitterDrawerHeader();
}

class _TwitterDrawerHeader extends State<TwitterDrawerHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(200)),
          child: Image.network(widget.ProfileImage),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: [
              Expanded(child: Text(widget.Displayname)),
              const Icon(
                Icons.arrow_drop_down_sharp,
                color: Colors.blueAccent,
              ),
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                const Text(
                  " Username ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.username.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            )),
        Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                const Text(
                  " Following ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.following.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            )),
        Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                const Text(
                  " Followers ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.follower.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ))
      ],
    );
  }
}

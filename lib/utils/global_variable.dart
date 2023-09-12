import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/screen/add_post_screen.dart';

import '../screen/feed_screen.dart';
import '../screen/profile_screen.dart';
import '../screen/search_screen.dart';

// ignore: constant_identifier_names
const WebScreenSize = 600;

List<Widget> homeScreenItems = [
  const feedscreen(),
  const searchscreen(),
  const addpostscreen(),
  const Text('notif'),
  profilescreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];

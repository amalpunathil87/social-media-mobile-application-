import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User {
  final String email;
  final String uid;
  final String photourl;
  final String username;
  final String bio;
  final List followers;
  final List following;
  const User(
      {required this.email,
      required this.bio,
      required this.photourl,
      required this.uid,
      required this.followers,
      required this.following,
      required this.username});

  Map<String, dynamic> tojson() => {
        'username': username,
        'uid': uid,
        'email': email,
        'photourl': photourl,
        'bio': bio,
        'followers': followers,
        'following': following,
      };
  static User fronsnap(DocumentSnapshot snapshort) {
    var snapshot = snapshort.data() as Map<String, dynamic>;

    return User(
      username: snapshot['username'],
      bio: snapshot['bio'],
      email: snapshot['email'],
      followers: snapshot['followers'],
      photourl: snapshot['photourl'],
      following: snapshot['following'],
      uid: snapshot['uid'],
    );
  }
}

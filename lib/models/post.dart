import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Post {
  final String description;
  final String uid;
  final String username;
  final String postid;
  // ignore: prefer_typing_uninitialized_variables
  final datepublished;
  final String posturl;
  final String profimage;
  final like;

  const Post({
    required this.description,
    required this.uid,
    required this.username,
    required this.postid,
    required this.datepublished,
    required this.posturl,
    required this.profimage,
    required this.like,
  });

  Map<String, dynamic> tojson() => {
        'description': description,
        'uid': uid,
        'username': username,
        'postid': postid,
        'datepublished': datepublished,
        'posturl': posturl,
        'profimage': profimage,
        'like': like,
      };
  static Post fronsnap(DocumentSnapshot snapshort) {
    var snapshot = snapshort.data() as Map<String, dynamic>;

    return Post(
      username: snapshot['username'],
      uid: snapshot['uid'],
      description: snapshot['description'],
      postid: snapshot['postid'],
      datepublished: snapshot['datepublished'],
      posturl: snapshot['posturl'],
      like: snapshot['like'],
      profimage: snapshot['profimage'],
    );
  }
}

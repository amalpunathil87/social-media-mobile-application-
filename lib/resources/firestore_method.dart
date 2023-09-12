import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram/models/post.dart';
import 'package:instagram/resources/storage.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post
  Future<String> uploadpost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profimage,
  ) async {
    String res = "some error occure";
    try {
      String photourl =
          await storagemethod().uploadimagestorage("posts", file, true);

      String postid = const Uuid().v1();

      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        postid: postid,
        datepublished: DateTime.now(),
        posturl: photourl,
        profimage: profimage,
        like: [],
      );

      _firestore.collection('posts').doc(postid).set(post.tojson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> likepost(String postid, String uid, List like) async {
    try {
      if (like.contains(uid)) {
        await _firestore.collection('posts').doc(postid).update({
          'like': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('posts').doc(postid).update({
          'like': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }

  Future<void> postcomment(String postid, String text, String uid, String name,
      String profilepic) async {
    try {
      if (text.isNotEmpty) {
        String commentid = const Uuid().v1();
        await _firestore
            .collection('posts')
            .doc(postid)
            .collection('comments')
            .doc(commentid)
            .set({
          'profilepic': profilepic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentid': commentid,
          'datepublished': DateTime.now(),
        });
      } else {
        print("text is empty");
      }
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }
  //deleting the post

  Future<void> deletepost(String postid) async {
    try {
      await _firestore.collection('posts').doc(postid).delete();
    } catch (err) {
      print(err.toString());
    }
  }

  Future<void> followuser(String uid, String followid) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();

      List following = (snap.data()! as dynamic)['following'];
      if (following.contains(followid)) {
        await _firestore.collection('users').doc(followid).update({
          'followers': FieldValue.arrayRemove([uid])
        });
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followid])
        });
      } else {
        await _firestore.collection('users').doc(followid).update({
          'followers': FieldValue.arrayUnion([uid])
        });
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followid])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

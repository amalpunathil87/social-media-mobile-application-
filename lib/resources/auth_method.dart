import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram/resources/storage.dart';
import 'package:instagram/models/user.dart' as model;

class Authmethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getuserdetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection("users").doc(currentUser.uid).get();
    return model.User.fronsnap(snap);
  }

  // sign up user
  Future<String> signupuser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "some error occure";
    try {
      if (email.isNotEmpty ||
              password.isNotEmpty ||
              username.isNotEmpty ||
              bio.isNotEmpty
          // file !=null
          ) {
        //register user

        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);

        String photourl = await storagemethod()
            .uploadimagestorage('profilepics', file, false);

        // add user to our database

        // ignore: unused_local_variable
        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          bio: bio,
          followers: [],
          following: [],
          photourl: photourl,
        );

        await _firestore.collection('users').doc(cred.user!.uid).set(
              user.tojson(),
            );
        //
        // await _firestore.collection("user").add({

        //   'username': username,
        //   'uid': cred.user!.uid,
        //   'email': email,
        //   'bio': bio,
        //   'followers': [],
        //   'following': [],
        // });
        res = "success";
      }
    }
    // on FirebaseAuthException catch (err) {
    //   if (err.code == 'invalid email') {
    //     res = "the email is badly formatted";
    //   } else if (err.code == 'weak password') {
    //     res = "password should be at 6 character";
    //   }
    // }
    catch (err) {
      res = err.toString();
    }
    return res;
  }
  // login user

  Future<String> loginuser(
      {required String email, required String password}) async {
    String res = "some error occurred";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        _auth.signInWithEmailAndPassword(email: email, password: password);
        res = "success";
      } else {
        res = "please enter all the fields ";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> signout() async {
    _auth.signOut();
  }
}

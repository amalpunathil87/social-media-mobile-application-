import 'package:flutter/cupertino.dart';
import 'package:instagram/models/user.dart';
import 'package:instagram/resources/auth_method.dart';

// ignore: camel_case_types
class userprovider with ChangeNotifier {
  User? _user;
  final Authmethod _authmethod = Authmethod();
  User get getuser => _user!;
  Future<void> refreshuser() async {
    User user = await _authmethod.getuserdetails();
    _user = user;
    notifyListeners();
  }
}

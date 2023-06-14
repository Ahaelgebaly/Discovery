import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserViewModel extends ChangeNotifier {

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  User? user;
  bool loading = false;

  FirebaseAuth auth = FirebaseAuth.instance;

  setUser() {
    user = auth.currentUser;
    notifyListeners();
  }
}

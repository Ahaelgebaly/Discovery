import 'dart:io';

import 'package:discovery/models/reel.dart';
import 'package:discovery/services/reel_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:discovery/models/post.dart';
import 'package:discovery/screens/mainscreen.dart';
import 'package:discovery/services/post_service.dart';
import 'package:discovery/services/user_service.dart';
import 'package:discovery/utils/firebase.dart';

class ReelsViewModel extends ChangeNotifier {
  //Services
  UserService userService = UserService();
  ReelService reelService = ReelService();

  //Keys
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //Variables
  bool loading = false;
  String? username;
  File? videoUrl ;
  final picker = ImagePicker();
  String? location;
  Position? position;
  Placemark? placemark;
  String? bio;
  String? description;
  String? email;
  String? commentData;
  String? ownerId;
  String? userId;
  String? type;
  File? userDp;
  String? videoLink;
  bool edit = false;
  String? id;

  //controllers
  TextEditingController locationTEC = TextEditingController();

  //Setters
  setEdit(bool val) {
    edit = val;
    notifyListeners();
  }

  setReel(ReelModel reel) {
    if (reel != null) {
      description = reel.description;
      videoLink = reel.videoUrl;
      location = reel.location;
      edit = true;
      edit = false;
      notifyListeners();
    } else {
      edit = false;
      notifyListeners();
    }
  }

  setUsername(String val) {
    print('SetName $val');
    username = val;
    notifyListeners();
  }

  setDescription(String val) {
    print('SetDescription $val');
    description = val;
    notifyListeners();
  }

  setLocation(String val) {
    print('SetCountry $val');
    location = val;
    notifyListeners();
  }

  setBio(String val) {
    print('SetBio $val');
    bio = val;
    notifyListeners();
  }

  //Functions
  pickreel({bool camera = false, BuildContext? context}) async {
    loading = true;
    notifyListeners();
    try {
      PickedFile? pickedFile = await picker.getVideo(
        source: camera ? ImageSource.camera : ImageSource.gallery,
      );
      videoUrl = File(pickedFile!.path);
      loading = false;
      notifyListeners();

    } catch (e) {
      loading = false;
      notifyListeners();
      showInSnackBar('Cancelled', context);
    }
  }

  getLocation() async {
    loading = true;
    notifyListeners();
    LocationPermission permission = await Geolocator.checkPermission();
    print(permission);
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      LocationPermission rPermission = await Geolocator.requestPermission();
      print(rPermission);
      await getLocation();
    } else {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position!.latitude, position!.longitude);
      placemark = placemarks[0];
      location = " ${placemarks[0].locality}, ${placemarks[0].country}";
      locationTEC.text = location!;
      print(location);
    }
    loading = false;
    notifyListeners();
  }

  uploadReels(BuildContext context) async {
    try {
      loading = true;
      notifyListeners();
      await reelService.uploadReel(videoUrl!, location!, description!);
      loading = false;
      resetReel();
      notifyListeners();
    } catch (e) {
      print(e);
      loading = false;
      resetReel();
      showInSnackBar('Uploaded successfully!', context);
      notifyListeners();
    }
  }



  resetReel() {
    videoUrl = null;
    description = null;
    location = null;
    edit = false;
    notifyListeners();
  }

  void showInSnackBar(String value, context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }
}

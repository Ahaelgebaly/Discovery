import 'dart:io';

import 'package:discovery/services/user_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:discovery/models/user.dart';

class EditProfileViewModel extends ChangeNotifier {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool validate = false;
  bool loading = false;
  UserService userService = UserService();
  final picker = ImagePicker();
  UserModel? user;
  String? Phone;
  String? username;
  String? bio;
  File? image;
  String? imgLink;

  setUser(UserModel val) {
    user = val;
    notifyListeners();
  }

  setImage(UserModel user) {
    imgLink = user.photoUrl;
  }

  setPhone(String val) {
    print('Phone $val');
    Phone = val;
    notifyListeners();
  }

  setBio(String val) {
    print('SetBio$val');
    bio = val;
    notifyListeners();
  }

  setUsername(String val) {
    print('SetUsername$val');
    username = val;
    notifyListeners();
  }

  editProfile(BuildContext context) async {
    FormState form = formKey.currentState!;
    form.save();
    if (!form.validate()) {
      validate = true;
      notifyListeners();
      showInSnackBar(
          'Please fix the errors in red before submitting.', context);
    } else {
      try {
        loading = true;
        notifyListeners();
        bool success = await userService.updateProfile(
          //  user: user,
          image: image,
          username: username,
          bio: bio,
          Phone: Phone,
        );
        print(success);
        if (success) {
          clear();
          Navigator.pop(context);
        }
      } catch (e) {
        loading = false;
        notifyListeners();
        print(e);
      }
      loading = false;
      notifyListeners();
    }
  }

  pickImage({bool camera = false, BuildContext? context}) async {
    loading = true;
    notifyListeners();
    try {
      PickedFile? pickedFile = await picker.getImage(
        source: camera ? ImageSource.camera : ImageSource.gallery,
      );

      image = File(pickedFile!.path);
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
      showInSnackBar('Cancelled', context);
    }
  }

  clear() {
    image = null;
    notifyListeners();
  }

  void showInSnackBar(String value, context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }
}

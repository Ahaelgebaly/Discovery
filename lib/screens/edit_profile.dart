import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:discovery/components/text_form_builder.dart';
import 'package:discovery/models/user.dart';
import 'package:discovery/utils/firebase.dart';
import 'package:discovery/utils/validation.dart';
import 'package:discovery/view_models/profile/edit_profile_view_model.dart';
import 'package:discovery/widgets/indicators.dart';

import 'mainscreen.dart';

class EditProfile extends StatefulWidget {
  final UserModel? user;

  const EditProfile({this.user});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  UserModel? user;

  String currentUid() {
    return firebaseAuth.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    EditProfileViewModel viewModel = Provider.of<EditProfileViewModel>(context);
    return LoadingOverlay(
      progressIndicator: circularProgress(context),
      isLoading: viewModel.loading,
      child: Scaffold(
        key: viewModel.scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey.shade200,
          toolbarHeight: 80,
          elevation: 0.0,
          leading: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TabScreen()));
            },
            child: Container(
              padding: EdgeInsets.only(left: 20),
              child: Icon(
                Icons.close,
                size: 40,
                color: Color(0xff3e97bd),
              ),
            ),
          ),
          centerTitle: true,
          title: Text("Edit Profile",
              style: TextStyle(
                fontFamily: 'Robot',
                fontWeight: FontWeight.w400,
                fontSize: 20,
              )),
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: GestureDetector(
                  onTap: () => viewModel.editProfile(context),
                  child: Icon(
                    Icons.check,
                    size: 40,
                    color: Color(0xff3e97bd),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: GestureDetector(
                onTap: () => viewModel.pickImage(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        offset: new Offset(0.0, 0.0),
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                  ),
                  child: viewModel.imgLink != null
                      ? Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: CircleAvatar(
                            radius: 65.0,
                            backgroundImage: NetworkImage(viewModel.imgLink!),
                          ),
                        )
                      : viewModel.image == null
                          ? Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: CircleAvatar(
                                radius: 65.0,
                                backgroundImage:
                                    NetworkImage(widget.user!.photoUrl!),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: CircleAvatar(
                                radius: 65.0,
                                backgroundImage: FileImage(viewModel.image!),
                              ),
                            ),
                ),
              ),
            ),
            SizedBox(height: 40.0),
            buildForm(viewModel, context)
          ],
        ),
      ),
    );
  }

  buildForm(EditProfileViewModel viewModel, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: viewModel.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            Center(
              child: Container(
                width: 329,
                child: TextFormBuilder(
                  enabled: !viewModel.loading,
                  initialValue: widget.user!.username,
                  prefix: Ionicons.person_outline,
                  hintText: "Username",
                  textInputAction: TextInputAction.next,
                  validateFunction: Validations.validateName,
                  onSaved: (String val) {
                    viewModel.setUsername(val);
                  },
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Center(
              child: Container(
                width: 329,
                child: TextFormBuilder(
                  enabled: !viewModel.loading,
                  prefix: Ionicons.phone_portrait_outline,
                  hintText: "phone number",
                  textInputAction: TextInputAction.next,
                  validateFunction: Validations.validatePhoneNumber,
                  onSaved: (String val) {
                    ;
                  },
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Center(
              child: Container(
                width: 329,
                child: TextFormField(
                  maxLines: null,
                  initialValue: widget.user!.bio,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value!.length > 1000) {
                      return 'Bio must be short';
                    }
                    return null;
                  },
                  onSaved: (String? val) {
                    viewModel.setBio(val!);
                  },
                  onChanged: (String val) {
                    viewModel.setBio(val);
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white70,
                    hintText: "  Bio",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

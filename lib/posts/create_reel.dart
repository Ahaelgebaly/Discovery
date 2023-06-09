import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discovery/view_models/auth/reels_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:discovery/components/custom_image.dart';
import 'package:discovery/models/user.dart';
import 'package:discovery/utils/firebase.dart';
import 'package:discovery/widgets/indicators.dart';
import 'package:video_player/video_player.dart';

class CreateReel extends StatefulWidget {
  @override
  State<CreateReel> createState() => _CreateReelState();

}

class _CreateReelState extends State<CreateReel> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;


  @override
  void initState() {

    super.initState();

    _controller = VideoPlayerController.network('',
    );
    _controller.play();
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    currentUserId() {
      return firebaseAuth.currentUser!.uid;
    }

    ReelsViewModel viewModel = Provider.of<ReelsViewModel>(context);

    return WillPopScope(
      onWillPop: () async {
        await viewModel.resetReel();
        return true;
      },
      child: LoadingOverlay(
        progressIndicator: circularProgress(context),
        isLoading: viewModel.loading,
        child: Scaffold(
          key: viewModel.scaffoldKey,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Ionicons.arrow_back_outline),
              onPressed: () {
                viewModel.resetReel();
                Navigator.pop(context);
              },
            ),
          ),
          body: ListView(
            padding: EdgeInsets.only(left: 32.0, right: 32.0),
            children: [
              StreamBuilder(
                stream: usersRef.doc(currentUserId()).snapshots(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    UserModel user = UserModel.fromJson(
                      snapshot.data!.data() as Map<String, dynamic>,
                    );
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 25.0,
                        backgroundImage: NetworkImage(user.photoUrl!),
                      ),
                      title: Text(
                        user.username!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        user.email!,
                      ),
                    );
                  }
                  return Container();
                },
              ),
              InkWell(
                onTap: () => showVideoChoices(context, viewModel),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width - 30,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    child: viewModel.videoLink != null
                        ? CustomImage(
                            imageUrl: viewModel.videoLink,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width - 30,
                            fit: BoxFit.cover,
                          )
                        : viewModel.videoUrl == null
                            ? Center(
                                child: Text(
                                  'Upload New Reel',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,

                                  ),
                                ),
                              )
                            : GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_controller.value.isPlaying) {
                            _controller.pause();
                          } else {
                            _controller.play();
                          }
                        });
                      },
                              child: FutureBuilder(
                                  future: _initializeVideoPlayerFuture,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      _controller = VideoPlayerController.network((viewModel.videoUrl!.path),
                                      );
                                      _initializeVideoPlayerFuture = _controller.initialize();
                                      _controller.play();
                                      return VideoPlayer(_controller);

                                    } else {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                ),
                            )),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                initialValue: viewModel.description,
                style: TextStyle(
                  color: Color(0xff205065),
                  fontFamily: 'Robot',
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  hintText: 'Write a Caption...',
                  hintStyle: TextStyle(
                      color:  Color(0xFF9593a8),
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none),
                ),
                maxLines: null,
                onChanged: (val) => viewModel.setDescription(val),
              ),
              SizedBox(height: 10.0),
              ListTile(
                contentPadding: EdgeInsets.all(0.0),
                title: Container(
                  width: 250.0,
                  child: TextFormField(
                    controller: viewModel.locationTEC,
                    style: TextStyle(
                      color: Color(0xff205065),
                      fontFamily: 'Robot',
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Location..',
                      hintStyle: TextStyle(
                          color:  Color(0xFF9593a8),
                          fontFamily: 'Roboto',
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),

                    ),
                    maxLines: null,
                    onChanged: (val) => viewModel.setLocation(val),
                  ),
                ),
                trailing: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),
                  child: IconButton(
                    tooltip: "Use your current location",
                    icon: Icon(
                      CupertinoIcons.location_solid,
                      size: 25.0,
                    ),
                    iconSize: 30.0,
                    color: Theme.of(context).colorScheme.secondary,
                    onPressed: () => viewModel.getLocation(),
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.only(bottom: 46),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 146,
                      height: 46,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: Color(0xff3e97bd),
                          )),
                      child: MaterialButton(
                        onPressed: () {
                          viewModel.resetReel();
                        },

                          child: Text(
                            'Clear',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Roboto',
                              color: Color(0xff3e97bd),
                            ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Container(
                      width: 146,
                      height: 46,
                      decoration: BoxDecoration(
                        color: Color(0xff3e97bd),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: MaterialButton(
                        onPressed: () async {
                          await viewModel.uploadReels(context);
                          Navigator.pop(context);
                          viewModel.resetReel();
                        },
                        child: Text(
                          'Share',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showVideoChoices(BuildContext context, ReelsViewModel viewModel) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: .4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.0),
              Center(
                child: Text(
                  'Select Image',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff205065),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(Ionicons.camera_outline,color:Color(0xff205065)),
                title: Text('Camera',
                  style: TextStyle(
                    fontSize: 16,
                    color:  Color(0xff205065),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  viewModel.pickreel(camera: true);
                },
              ),
              ListTile(
                leading: Icon(Ionicons.image,color: Color(0xff205065)),
                title: Text('Gallery',
                  style: TextStyle(
                    fontSize: 16,
                    color:Color(0xff205065),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  viewModel.pickreel();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

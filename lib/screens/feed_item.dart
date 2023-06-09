import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discovery/models/reel.dart';
import 'package:discovery/models/user.dart';
import 'package:discovery/pages/profile.dart';
import 'package:discovery/screens/follow_reels.dart';
import 'package:discovery/screens/view_reel.dart';
import 'package:discovery/services/reel_service.dart';
import 'package:discovery/utils/firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FeedItem extends StatefulWidget {
  final ReelModel? reel;

  FeedItem({this.reel});

  currentUserId() {
    return firebaseAuth.currentUser!.uid;
  }

  final ReelService services = ReelService();

  final DateTime timestamp = DateTime.now();

  @override
  State<FeedItem> createState() => _FeedItemState();
}

class _FeedItemState extends State<FeedItem> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.reel!.videoUrl!);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        child: GestureDetector(
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
              if (snapshot.connectionState == ConnectionState.done) {
                return VideoPlayer(_controller);
              } else {
                return Center(
                  child: CircularProgressIndicator(color: Color(0xff3e97bd)),
                );
              }
            },
          ),
        ),
      ),
      StreamBuilder(
          stream: usersRef.doc(widget.reel!.ownerId!).snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasData) {
              DocumentSnapshot snap = snapshot.data!;
              UserModel user =
                  UserModel.fromJson(snap.data() as Map<String, dynamic>);
              return Stack(children: [
                Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(width: 500,
                      child: Column(

                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 200),
                                        child: GestureDetector(
                                          onTap: () => showProfile(context,
                                              profileId: user.id!),
                                          child: Row(
                                            children: [
                                              user.photoUrl!.isEmpty
                                                  ? CircleAvatar(
                                                      child: Center(
                                                        child: Text(
                                                          '${user.username![0].toUpperCase()}',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15.0,
                                                            fontWeight:
                                                                FontWeight.w900,
                                                          ),
                                                        ),
                                                      ),
                                                      radius: 20,
                                                    )
                                                  : CircleAvatar(
                                                      radius: 20.0,
                                                      backgroundImage:
                                                          CachedNetworkImageProvider(
                                                        '${user.photoUrl}',
                                                      ),
                                                    ),
                                              SizedBox(width: 10),
                                              Text(
                                                '${widget.reel!.username! ?? ""}',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Container(
                                                width: 79,
                                                height: 30,
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
                                                child: Followreels(),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: 400,
                                        child: Text(
                                          '"${widget.reel!.description! ?? ""}"',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                            overflow: TextOverflow.visible,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: 400,
                                        child: Text(
                                          '${widget.reel!.location! ?? 'Discovery'}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                          ),
                                          overflow: TextOverflow.visible,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                ])
                          ]),
                    ))
              ]);
            } else {
              return Container();
            }
          })
    ]);
  }

  showProfile(BuildContext context, {String? profileId}) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (_) => Profile(profileId: profileId),
      ),
    );
  }
}
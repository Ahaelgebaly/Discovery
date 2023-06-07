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

  int index = 0;

  final List<bool> favourite = <bool>[
    true,
    true,
    true,
    true,
    true,
    true,
  ];

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
    return Container(
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
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }


}

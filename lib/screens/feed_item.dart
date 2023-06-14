import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discovery/models/reel.dart';
import 'package:discovery/models/user.dart';
import 'package:discovery/pages/profile.dart';
import 'package:discovery/screens/edit_profile.dart';
import 'package:discovery/screens/view_reel.dart';
import 'package:discovery/services/reel_service.dart';
import 'package:discovery/utils/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FeedItem extends StatefulWidget {

  final ReelModel? reel;
  final profileId;

  FeedItem({this.profileId,this.reel});


  final ReelService services = ReelService();

  final DateTime timestamp = DateTime.now();




  @override
  State<FeedItem> createState() => _FeedItemState();
}

class _FeedItemState extends State<FeedItem> {
  User? user;
  bool isLoading = false;
  int postCount = 0;
  int followersCount = 0;
  int followingCount = 0;
  bool isFollowing = false;
  UserModel? users;
  final DateTime timestamp = DateTime.now();
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    checkIfFollowing();
    _controller = VideoPlayerController.network(widget.reel!.videoUrl!);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.play();
  }

  checkIfFollowing() async {
    DocumentSnapshot doc = await followersRef
        .doc(widget.reel!.ownerId)
        .collection('userFollowers')
        .doc(currentUserId())
        .get();
    setState(() {
      isFollowing = doc.exists;
    });
  }

  late VideoPlayerController _controller;

  late Future<void> _initializeVideoPlayerFuture;



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
                    child: Column(

                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: 400,
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
                                            buildFollowButton(widget.profileId),
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
                        ]))
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


  buildFollowButton(user) {
    //if isMe then display "edit profile"
     if (isFollowing) {
      return buildButton(
        text: "Unfollow",
        function: handleUnfollow,
      );
    } else if (!isFollowing) {
      return buildButton(
        text: "Follow",
        function: handleFollow,
      );
    }
  }
  buildButton({String? text, Function()? function}) {
    return Center(
      child: ElevatedButton(
        onPressed: function!,
        child:Text(
          text!,
          style: TextStyle(
              color:Colors.white,
              fontWeight: FontWeight.w500,fontSize: 10,fontFamily: 'Roboto'

          ),
        ),
        style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(22),side: BorderSide(color: Colors.white))
        ),
      ),
    );
  }

  handleUnfollow() async {
    DocumentSnapshot doc = await usersRef.doc(currentUserId()).get();
    users = UserModel.fromJson(doc.data() as Map<String, dynamic>);
    setState(() {
      isFollowing = false;
    });
    //remove follower
    followersRef
        .doc(widget.reel!.ownerId)
        .collection('userFollowers')
        .doc(currentUserId())
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    //remove following
    followingRef
        .doc(currentUserId())
        .collection('userFollowing')
        .doc(widget.reel!.ownerId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    //remove from notifications feeds
    notificationRef
        .doc(widget.reel!.ownerId)
        .collection('notifications')
        .doc(currentUserId())
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
  }

  handleFollow() async {
    DocumentSnapshot doc = await usersRef.doc(currentUserId()).get();
    users = UserModel.fromJson(doc.data() as Map<String, dynamic>);
    setState(() {
      isFollowing = true;
    });
    //updates the followers collection of the followed user
    followersRef
        .doc(widget.reel!.ownerId)
        .collection('userFollowers')
        .doc(currentUserId())
        .set({});
    //updates the following collection of the currentUser
    followingRef
        .doc(currentUserId())
        .collection('userFollowing')
        .doc(widget.reel!.ownerId)
        .set({});
    //update the notification feeds
    notificationRef
        .doc(widget.reel!.ownerId)
        .collection('notifications')
        .doc(currentUserId())
        .set({
      "type": "follow",
      "ownerId": widget.reel!.ownerId,
      "username": users?.username,
      "userId": users?.id,
      "userDp": users?.photoUrl,
      "timestamp": timestamp,
    });
  }

}


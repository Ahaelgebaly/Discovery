import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discovery/models/reel.dart';
import 'package:discovery/screens/view_reel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:like_button/like_button.dart';
import 'package:discovery/components/custom_card.dart';
import 'package:discovery/components/custom_image.dart';
import 'package:discovery/models/user.dart';
import 'package:discovery/pages/profile.dart';
import 'package:discovery/screens/comment.dart';
import 'package:discovery/screens/view_image.dart';
import 'package:discovery/services/post_service.dart';
import 'package:discovery/utils/firebase.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:video_player/video_player.dart';
class UserReel extends StatelessWidget {
  final ReelModel? reel;

  UserReel({this.reel});

  final DateTime timestamp = DateTime.now();

  currentUserId() {
    return firebaseAuth.currentUser!.uid;
  }

  final PostService services = PostService();

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: () {},
      borderRadius: BorderRadius.circular(10.0),
      child: OpenContainer(
        transitionType: ContainerTransitionType.fadeThrough,
        openBuilder: (BuildContext context, VoidCallback _) {
          return ViewReel(reel: reel);
        },
        closedElevation: 0.0,
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        onClosed: (v) {},
        closedColor: Theme.of(context).cardColor,
        closedBuilder: (BuildContext context, VoidCallback openContainer) {
          return Stack(
            children: [
              Column(
                children: [
                  buildUser(context),
                  ClipRRect(
                    child: VideoPlayer(
                      reel!.videoUrl as VideoPlayerController
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 3.0, vertical: 5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0),
                          child: Row(
                            children: [
                              buildLikeButton(),
                              SizedBox(width: 5.0),
                              InkWell(
                                borderRadius: BorderRadius.circular(10.0),
                                onTap: () {

                                },
                                child: Icon(
                                  CupertinoIcons.chat_bubble,
                                  size: 25.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 0.0),
                                child: StreamBuilder(
                                  stream: likesRef
                                      .where('reelId', isEqualTo: reel!.reelId)
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasData) {
                                      QuerySnapshot snap = snapshot.data!;
                                      List<DocumentSnapshot> docs = snap.docs;
                                      return buildLikesCount(
                                          context, docs.length ?? 0);
                                    } else {
                                      return buildLikesCount(context, 0);
                                    }
                                  },
                                ),
                              ),
                            ),
                            SizedBox(width: 5.0),
                            StreamBuilder(
                              stream: commentRef
                                  .doc(reel!.reelId!)
                                  .collection("comments")
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  QuerySnapshot snap = snapshot.data!;
                                  List<DocumentSnapshot> docs = snap.docs;
                                  return buildCommentsCount(
                                      context, docs.length ?? 0);
                                } else {
                                  return buildCommentsCount(context, 0);
                                }
                              },
                            ),
                          ],
                        ),
                        Visibility(
                          visible: reel!.description != null &&
                              reel!.description.toString().isNotEmpty,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0, top: 3.0),
                            child: Text(
                              '${reel?.description ?? ""}',
                              style: TextStyle(
                                color: Color(0xff205065),
                                fontSize: 15.0,
                              ),
                              maxLines: 2,
                            ),
                          ),
                        ),
                        SizedBox(height: 3.0),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            timeago.format(reel!.timestamp!.toDate()),
                            style: TextStyle(fontSize: 10.0),
                          ),
                        ),
                        // SizedBox(height: 5.0),
                      ],
                    ),
                  )
                ],

              ),
            ],
          );
        },
      ),
    );
  }

  buildLikeButton() {
    return StreamBuilder(
      stream: likesRef
          .where('reelId', isEqualTo: reel!.reelId)
          .where('userId', isEqualTo: currentUserId())
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<QueryDocumentSnapshot> docs = snapshot.data?.docs ?? [];


          Future<bool> onLikeButtonTapped(bool isLiked) async {
            if (docs.isEmpty) {
              likesRef.add({
                'userId': currentUserId(),
                'reelId': reel!.reelId,
                'dateCreated': Timestamp.now(),
              });
              return !isLiked;
            } else {
              likesRef.doc(docs[0].id).delete();
              services.removeLikeFromNotification(
                  reel!.ownerId!, reel!.reelId!, currentUserId());
              return isLiked;
            }
          }

          return LikeButton(
            onTap: onLikeButtonTapped,
            size: 25.0,
            circleColor:
            CircleColor(start: Color(0xffFFC0CB), end: Color(0xffff0000)),
            bubblesColor: BubblesColor(
                dotPrimaryColor: Color(0xffFFA500),
                dotSecondaryColor: Color(0xffd8392b),
                dotThirdColor: Color(0xffFF69B4),
                dotLastColor: Color(0xffff8c00)),
            likeBuilder: (bool isLiked) {
              return Icon(
                docs.isEmpty ? Ionicons.heart_outline : Ionicons.heart,
                color: docs.isEmpty
                    ? Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black
                    : Colors.red,
                size: 25,
              );
            },
          );
        }
        return Container();
      },
    );
  }


  buildLikesCount(BuildContext context, int count) {
    return Padding(
      padding: const EdgeInsets.only(left: 7.0),
      child: Text(
        '$count likes',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 10.0,
        ),
      ),
    );
  }

  buildCommentsCount(BuildContext context, int count) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.5),
      child: Text(
        '-   $count comments',
        style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.bold),
      ),
    );
  }

  buildUser(BuildContext context) {
    return StreamBuilder(
      stream: usersRef.doc(reel!.ownerId).snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          DocumentSnapshot snap = snapshot.data!;
          UserModel user =
          UserModel.fromJson(snap.data() as Map<String, dynamic>);
          return Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: GestureDetector(
                onTap: () => showProfile(context, profileId: user.id!),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          user.photoUrl!.isEmpty
                              ? CircleAvatar(
                            radius: 20.0,
                            backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                            child: Center(
                              child: Text(
                                '${user.username![0].toUpperCase()}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          )
                              : CircleAvatar(
                            radius: 20.0,
                            backgroundImage: CachedNetworkImageProvider(
                              '${user.photoUrl}',
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${reel?.username ?? ""}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.visible,
                              ),
                              Text(
                                '${reel?.location ?? 'Discovery'}',
                                style: TextStyle(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.visible,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.more_vert_outlined,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
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

import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:like_button/like_button.dart';
import 'package:discovery/components/custom_card.dart';
import 'package:discovery/components/custom_image.dart';
import 'package:discovery/models/post.dart';
import 'package:discovery/models/user.dart';
import 'package:discovery/pages/profile.dart';
import 'package:discovery/screens/comment.dart';
import 'package:discovery/screens/view_image.dart';
import 'package:discovery/services/post_service.dart';
import 'package:discovery/utils/firebase.dart';
import 'package:timeago/timeago.dart' as timeago;

class UserPost extends StatelessWidget {
  final PostModel? post;

  UserPost({this.post});

  final DateTime timestamp = DateTime.now();

  currentUserId() {
    return firebaseAuth.currentUser!.uid;
  }

  final PostService services = PostService();

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: () {},
      borderRadius: BorderRadius.circular(20.0),
      child: OpenContainer(
        transitionType: ContainerTransitionType.fadeThrough,
        openBuilder: (BuildContext context, VoidCallback _) {
          return Comments(post: post);
        },
        closedElevation: 0.0,
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        onClosed: (v) {},
        closedColor: Colors.white24,
        closedBuilder: (BuildContext context, VoidCallback openContainer) {
          return Stack(
            children: [
              ClipRRect(
                child: CustomImage(
                  imageUrl: post?.mediaUrl ?? '',
                  height: 250,
                  fit: BoxFit.fill,
                ),
              ),
              buildUser(context),
              Padding(
                padding: EdgeInsets.only(left: 300, top: 50),
                child: Column(
                  children: [
                    buildLikeButton(),
                    SizedBox(height: 5.0),
                    InkWell(
                      borderRadius: BorderRadius.circular(10.0),
                      onTap: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (_) => Comments(post: post),
                          ),
                        );
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: Colors.white24,
                        ),
                        child: Icon(
                          CupertinoIcons.chat_bubble_fill,
                          color: Colors.white,
                          size: 25.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    buildTripButton(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 190, left: 10, right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: post!.caption != null &&
                          post!.caption.toString().isNotEmpty,
                      child: Text(
                        '${post?.caption ?? ""}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                        ),
                        maxLines: 1,
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            RatingBarIndicator(
                              rating: post!.rating!,
                              unratedColor: Colors.grey,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 15,
                              direction: Axis.horizontal,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '(${post!.rating ?? '0'})',
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto',
                                color: Colors.amber,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black26),
                          child: Padding(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            child: Text(
                              timeago.format(post!.timestamp!.toDate()),
                              style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
          .where('postId', isEqualTo: post!.postId)
          .where('userId', isEqualTo: currentUserId())
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<QueryDocumentSnapshot> docs = snapshot.data?.docs ?? [];
          Future<bool> onLikeButtonTapped(bool isLiked) async {
            if (docs.isEmpty) {
              likesRef.add({
                'userId': currentUserId(),
                'postId': post!.postId,
                'dateCreated': Timestamp.now(),
              });
              addLikesToNotification();
              return !isLiked;
            } else {
              likesRef.doc(docs[0].id).delete();
              services.removeLikeFromNotification(
                  post!.ownerId!, post!.postId!, currentUserId());
              return isLiked;
            }
          }

          return Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.white24,
            ),
            child: LikeButton(
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
                          : Colors.white
                      : Colors.red,
                  size: 25,
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }

  buildTripButton() {
    return StreamBuilder(
      stream: tripsRef
          .where('postId', isEqualTo: post!.postId)
          .where('userId', isEqualTo: currentUserId())
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<QueryDocumentSnapshot> docs = snapshot.data?.docs ?? [];
          Future<bool> onLikeButtonTapped(bool isTapped) async {
            if (docs.isEmpty) {
              tripsRef.add({
                'postId': post!.postId,
                'caption': post!.caption,
                'description': post!.description,
                'howToGetThere': post!.howToGetThere,
                'id': post!.id,
                'location': post!.location,
                'mediaUrl': post!.mediaUrl,
                'ownerId': post!.ownerId,
                'rating': post!.rating,
                'timestamp': post!.timestamp,
                'username': post!.username,
                'userId': currentUserId(),
                'dateCreated': Timestamp.now(),
              });
              addTripToNotification();
              return !isTapped;
            } else {
              tripsRef.doc(docs[0].id).delete();
              services.removeTripFromNotification(
                  post!.ownerId!, post!.postId!, currentUserId());
              return isTapped;
            }
          }

          return LikeButton(
            onTap: onLikeButtonTapped,
            circleColor:
            CircleColor(start: Color(0xffFFC0CB), end: Color(0xffff0000)),
            bubblesColor: BubblesColor(
                dotPrimaryColor: Colors.amber.shade100,
                dotSecondaryColor: Colors.amber.shade200,
                dotThirdColor: Colors.amber.shade300,
                dotLastColor: Colors.amber.shade400),
            likeBuilder: (bool isTapped) {
              return Icon(
                docs.isEmpty
                    ? Icons.bookmark_add_rounded
                    : Icons.bookmark_added_rounded,
                color: docs.isEmpty
                    ? Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.white
                    : Colors.amber.shade500,
                size: 33,
              );
            },
          );
        }
        return Container();
      },
    );
  }

  addLikesToNotification() async {
    bool isNotMe = currentUserId() != post!.ownerId;

    if (isNotMe) {
      DocumentSnapshot doc = await usersRef.doc(currentUserId()).get();
      user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
      services.addLikesToNotification(
        "like",
        user!.username!,
        currentUserId(),
        post!.postId!,
        post!.mediaUrl!,
        post!.ownerId!,
        user!.photoUrl!,
      );
    }
  }
  addTripToNotification() async {
    bool isNotMe = currentUserId() != post!.ownerId;

    if (isNotMe) {
      DocumentSnapshot doc = await usersRef.doc(currentUserId()).get();
      user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
      services.addTripToNotification(
        "trip",
        user!.username!,
        currentUserId(),
        post!.postId!,
        post!.mediaUrl!,
        post!.ownerId!,
        user!.photoUrl!,
      );
    }
  }

  buildLikesCount(BuildContext context, int count) {
    return Padding(
      padding: const EdgeInsets.only(left: 250.0),
      child: Text(
        '$count likes',
        style: TextStyle(
          color: Colors.white,
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
        '  $count comments',
        style: TextStyle(
            fontSize: 8.5, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  buildUser(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.black26),
      child: StreamBuilder(
        stream: usersRef.doc(post!.ownerId).snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            DocumentSnapshot snap = snapshot.data!;
            UserModel user =
                UserModel.fromJson(snap.data() as Map<String, dynamic>);
            return Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 60,
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
                                          color: Colors.black,
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
                                  '${post?.username ?? ""}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.visible,
                                ),
                                Text(
                                  '${post?.location ?? 'Discovery'}',
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.visible,
                                ),
                              ],
                            ),
                          ],
                        ),
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
      ),
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

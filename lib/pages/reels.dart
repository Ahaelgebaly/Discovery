import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discovery/models/reel.dart';
import 'package:discovery/models/user.dart';
import 'package:discovery/pages/profile.dart';
import 'package:discovery/services/reel_service.dart';
import 'package:discovery/utils/firebase.dart';
import 'package:discovery/widgets/indicators.dart';
import 'package:flutter/cupertino.dart';

import '../screens/feed_item.dart';
import '../screens/follow_reels.dart';
import 'package:flutter/material.dart';

class Reels extends StatefulWidget {
  final ReelModel? reel;

  Reels({this.reel});

  currentUserId() {
    return firebaseAuth.currentUser!.uid;
  }

  final DateTime timestamp = DateTime.now();

  @override
  State<Reels> createState() => _ReelsState();
}

class _ReelsState extends State<Reels> {
  int currentIndex = 0;

  int page = 5;
  bool loadingMore = false;
  ScrollController scrollController = ScrollController();

  final ReelService services = ReelService();

  @override
  void initState() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          page = page + 5;
          loadingMore = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: FutureBuilder(
        future:
            reelRef.orderBy('timestamp', descending: true).limit(page).get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            var snap = snapshot.data;
            List docs = snap!.docs;
            return PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: docs.length,
              itemBuilder: (context, index) {
                ReelModel reels = ReelModel.fromJson(docs[index].data());
                return Stack(children: [
                  FeedItem(reel: reels),
                  StreamBuilder(
                      stream: usersRef.doc(widget.reel!.ownerId!).snapshots(),
                      builder:
                          (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasData) {
                          DocumentSnapshot snap = snapshot.data!;
                          UserModel user = UserModel.fromJson(
                              snap.data() as Map<String, dynamic>);
                          return Stack(children: [
                            Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                SizedBox(height: 50),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 70),
                                                  child: GestureDetector(
                                                    onTap: () => showProfile(
                                                        context,
                                                        profileId: user.id!),
                                                    child: Row(
                                                      children: [
                                                        user.photoUrl!.isEmpty
                                                            ? CircleAvatar(
                                                                child: Center(
                                                                  child: Text(
                                                                    '${user.username![0].toUpperCase()}',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          15.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900,
                                                                    ),
                                                                  ),
                                                                ),
                                                                radius: 16,
                                                              )
                                                            : CircleAvatar(
                                                                radius: 16.0,
                                                                backgroundImage:
                                                                    CachedNetworkImageProvider(
                                                                  '${user.photoUrl}',
                                                                ),
                                                              ),
                                                        SizedBox(width: 6),
                                                        Text(
                                                          '${widget.reel!.username! ?? ""}',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            color: Colors.black,
                                                          ),
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                        SizedBox(width: 15),
                                                        Container(
                                                          width: 80,
                                                          height: 30,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          40)),
                                                          child: Followreels(),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '${widget.reel!.description! ?? ''}',
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '${widget.reel!.location! ?? 'Discovery'}',
                                                  style: TextStyle(
                                                    fontSize: 10.0,
                                                    fontWeight: FontWeight.w900,
                                                    color: Colors.black,
                                                  ),
                                                  overflow:
                                                      TextOverflow.visible,
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
              },
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return circularProgress(context);
          } else
            return Center(
              child: Text(
                'No Reels',
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
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

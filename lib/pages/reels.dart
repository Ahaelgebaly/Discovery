import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discovery/models/reel.dart';
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


}

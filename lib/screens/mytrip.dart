import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discovery/models/post.dart';
import 'package:discovery/models/trip.dart';
import 'package:discovery/utils/firebase.dart';
import 'package:discovery/widgets/indicators.dart';
import 'package:discovery/widgets/usertrip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class mytrip extends StatefulWidget {
  final userId;

  mytrip({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<mytrip> createState() => _mytripState();
}

class _mytripState extends State<mytrip> {
  int page = 5;
  bool loadingMore = false;
  ScrollController scrollController = ScrollController();

  currentUserId() {
    return firebaseAuth.currentUser!.uid;
  }

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
    return Scaffold(
      appBar: AppBar(title: Text('My Trip')),
      body: RefreshIndicator(
        color: Theme.of(context).colorScheme.secondary,
        onRefresh: () =>
            tripsRef.orderBy('rating', descending: false).limit(page).get(),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 10,
                child: FutureBuilder(
                  future: tripsRef
                      .where('userId', isEqualTo: currentUserId())
                      .get(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      var snap = snapshot.data;
                      List docs = snap!.docs;
                      return ListView.builder(
                        controller: scrollController,
                        itemCount: docs.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          PostModel trips =
                              PostModel.fromJson(docs[index].data());
                          return Container(
                            width: 329,
                            height: 250,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: 32, left: 32, bottom: 20),
                              child: UserTrip(post: trips),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return circularProgress(context);
                    } else {
                      return Center(
                        child: Center(
                            child: Text(
                          'Your Trips List Is Empty',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(31, 80, 100, 1),
                          ),
                        )),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

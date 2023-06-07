import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discovery/pages/feeds.dart';
import 'package:discovery/pages/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:like_button/like_button.dart';
import 'package:discovery/components/stream_comments_wrapper.dart';
import 'package:discovery/models/comments.dart';
import 'package:discovery/models/post.dart';
import 'package:discovery/models/user.dart';
import 'package:discovery/services/post_service.dart';
import 'package:discovery/utils/firebase.dart';
import 'package:discovery/widgets/cached_image.dart';
import 'package:timeago/timeago.dart' as timeago;


class Comments extends StatefulWidget {

  final PostModel? post;

  Comments({this.post});

  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  UserModel? user;

  PostService services = PostService();
  final DateTime timestamp = DateTime.now();
  TextEditingController commentsTEC = TextEditingController();

  currentUserId() {
    return firebaseAuth.currentUser!.uid;
  }
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            children: [

              Flexible(
                child: ListView(
                  children: [
                    buildFullPost(),
                    SizedBox(height: 5,),
                    StreamBuilder(
                      stream: usersRef.doc(widget.post!.ownerId).snapshots(),
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
                                  padding: const EdgeInsets.only(left: 30.0,right: 32),
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
                                                '${widget.post?.username ?? ""}',
                                                style:TextStyle(color: Color(0xff205065),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    fontFamily: 'Roboto'
                                                ),
                                                overflow: TextOverflow.visible,
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(bottom: 2),
                                                    child: Icon(Ionicons.time_outline, size: 16.0,color: Color(0xFF9593a8)),
                                                  ),
                                                  SizedBox(width: 2.0),
                                                  Text(
                                                    timeago.format(widget.post!.timestamp!.toDate()),
                                                    style:TextStyle(color: Color(0xFF9593a8),
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 11,
                                                        fontFamily: 'Roboto'
                                                    ),
                                                  ),
                                                ],
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
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 32),
                      child: Text('About',style:
                      TextStyle(color: Color(0xff205065),
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          fontFamily: 'Roboto'
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 32,right: 32),
                      child: ExpandableText(
                        text:'is a town in the South Sinai Governorate of Egypt, situated at the foot of the mountain Mount Sinai.'
                            ' The city is the site of Saint Catherine\'s Monastery.[2] The city is 1,586 metres '
                            '(5,203 ft) above sea level and is 120 kilometres (75 mi) away from Nuweiba.[2] In 1994, '
                            'its population was 4,603 people. The Saint Catherine area is a UNESCO world heritage site, '
                            'officially declared as such in 2002.[3]',
                        maxLines:  20,
                        minLines: 5,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Roboto',
                          color: Color(0xFF9593a8),
                        ),
                        expandText: 'Read less',
                        collapseText: 'Read more',
                        linkColor: Color(0xff3e97bd),
                        onExpand: () {
                          setState(() {
                            _isExpanded = true;
                          });
                        },
                        onCollapse: () {
                          setState(() {
                            _isExpanded = false;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,

                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 32),
                      child: Text(
                        'How To Get There',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                          color: Color(0xff205065),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 32,right: 32),
                      child: ExpandableText(
                        text:"There is a daily bus service from Cairo to St Catherine. The bus leaves from Cairo each morning at 11 AM. It arrives in St Catherine’s the same day at 6 PM. From St. Catherine’s the bus leaves at 6 AM, arriving in Cairo at approximately 1 PM From Cairo, it is advisable to buy your ticket a day in advance and arrive at the terminal 1 hour prior on the day of departure. "
                            "Tickets may not be purchased in advance if traveling in the other direction from St Catherine’s to Cairo.",
                        maxLines:  20,
                        minLines: 5,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Roboto',
                          color: Color(0xFF9593a8),
                        ),
                        expandText: 'Read less',
                        collapseText: 'Read more',
                        linkColor: Color(0xff3e97bd),
                        onExpand: () {
                          setState(() {
                            _isExpanded = true;
                          });
                        },
                        onCollapse: () {
                          setState(() {
                            _isExpanded = false;
                          });
                        },
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,

                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 32),
                      child: Text('Comments',style:
                      TextStyle(color: Color(0xff205065),
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        fontFamily: 'Roboto'
                      ),),
                    ),
                    SizedBox(height: 10,),
                    Flexible(
                      child: buildComments(),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                    constraints: BoxConstraints(
                      maxHeight: 190.0,
                    ),
                    child: Container(
                      width:329,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(18),color: Colors.white),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Flexible(
                            child: ListTile(
                              contentPadding: EdgeInsets.all(0),
                              title: TextField(
                                textCapitalization: TextCapitalization.sentences,
                                controller: commentsTEC,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color:
                                      Theme.of(context).textTheme.headline6!.color,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10),
                                 border: UnderlineInputBorder(borderSide: BorderSide.none),
                                  hintText: "write your comment...",
                                  hintStyle: TextStyle(
                                    fontSize: 15.0,
                                    color: Color(0xFF9593a8),
                                  ),
                                ),
                                maxLines: null,
                              ),
                              trailing: GestureDetector(
                                onTap: () async {
                                  await services.uploadComment(
                                    currentUserId(),
                                    commentsTEC.text,
                                    widget.post!.postId!,
                                    widget.post!.ownerId!,
                                    widget.post!.mediaUrl!,
                                  );
                                  commentsTEC.clear();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Icon(
                                    Icons.send,
                                    color: Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  buildFullPost() {
    var post;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
          height: 374.0,
          width: MediaQuery.of(context).size.width ,
          child: cachedNetworkImage(widget.post!.mediaUrl!),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0,left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(
                          context,
                          MaterialPageRoute(builder: (context)=> Feeds())
                      );
                    },
                    icon: CircleAvatar(
                      radius: 15.0,
                      backgroundColor: Colors.white24,
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Color(0xff3e97bd),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 250.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post!.description!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                      ),
                      maxLines: 1,
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined,color: Theme.of(context).colorScheme.secondary,size: 15, ),
                        Text(
                          '${widget.post!.location ?? 'Discovery'}',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Roboto',
                            color:Theme.of(context).colorScheme.secondary,
                          ),
                          overflow: TextOverflow.visible,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              /*SizedBox(height: 4.0),
              Row(
                children: [
                  Text(
                    timeago.format(widget.post!.timestamp!.toDate()),
                    style: TextStyle(),
                  ),
                  SizedBox(width: 3.0),
                  StreamBuilder(
                    stream: likesRef
                        .where('postId', isEqualTo: widget.post!.postId)
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        QuerySnapshot snap = snapshot.data!;
                        List<DocumentSnapshot> docs = snap.docs;
                        return buildLikesCount(context, docs.length ?? 0);
                      } else {
                        return buildLikesCount(context, 0);
                      }
                    },
                  ),
                ],
              ),*/
            ],
          ),
        ),
      ],
    );
  }
  buildComments() {
    return Padding(
      padding: const EdgeInsets.only(right: 32,left: 32,),
      child: Container(
        width: 329,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),
        child: CommentsStreamWrapper(
          shrinkWrap: true,
          // padding: const EdgeInsets.symmetric(horizontal: 20.0),
          stream: commentRef
              .doc(widget.post!.postId)
              .collection('comments')
              .orderBy('timestamp', descending: true)
              .snapshots(),
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (_, DocumentSnapshot snapshot) {
            CommentModel comments =
                CommentModel.fromJson(snapshot.data() as Map<String, dynamic>);
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 ListTile(
                  leading: CircleAvatar(
                  radius: 20.0,
                 backgroundImage: NetworkImage(comments.userDp!),
            ),
                  title: Text(
                   comments.username!,
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                  subtitle: Text(
                     timeago.format(comments.timestamp!.toDate()),
                     style: TextStyle(fontSize: 12.0),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                   child: Text(
                     comments.comment!,
                     style: TextStyle(fontWeight: FontWeight.w400,color: Color(0xFF9593a8)),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(top: 5),
                   child: Divider(
                     height: 10,
                     color: Color(0xFF9593a8),
                     thickness: 1,
                     indent: 20,
                     endIndent: 20,
                   ),
                 ),
               ],
             );
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: CachedNetworkImageProvider(comments.userDp!),
                      ),
                      SizedBox(width: 10.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            comments.username!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                          Text(
                            timeago.format(comments.timestamp!.toDate()),
                            style: TextStyle(fontSize: 10.0),
                          ),
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Text( comments.comment!.trim()),
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  buildLikeButton() {
    return StreamBuilder(
      stream: likesRef
          .where('postId', isEqualTo: widget.post!.postId)
          .where('userId', isEqualTo: currentUserId())
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<QueryDocumentSnapshot> docs = snapshot.data?.docs ?? [];
          // return IconButton(
          //   onPressed: () {
          //     if (docs.isEmpty) {
          //       likesRef.add({
          //         'userId': currentUserId(),
          //         'postId': widget.post!.postId,
          //         'dateCreated': Timestamp.now(),
          //       });
          //       addLikesToNotification();
          //     } else {
          //       likesRef.doc(docs[0].id).delete();
          //
          //       removeLikeFromNotification();
          //     }
          //   },
          //   icon: docs.isEmpty
          //       ? Icon(
          //           CupertinoIcons.heart,
          //         )
          //       : Icon(
          //           CupertinoIcons.heart_fill,
          //           color: Colors.red,
          //         ),
          // );
          ///added animated like button
          Future<bool> onLikeButtonTapped(bool isLiked) async {
            if (docs.isEmpty) {
              likesRef.add({
                'userId': currentUserId(),
                'postId': widget.post!.postId,
                'dateCreated': Timestamp.now(),
              });
              addLikesToNotification();
              return !isLiked;
            } else {
              likesRef.doc(docs[0].id).delete();
              removeLikeFromNotification();
              return isLiked;
            }
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.black12),
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
                    color: docs.isEmpty ? Colors.grey : Colors.red,
                    size: 25,
                  );
                },
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  buildLikesCount(BuildContext context, int count) {
    return Padding(
      padding: const EdgeInsets.only(left: 250.0,top: 30),
      child: Text(
        '$count likes',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 10.0,
        ),
      ),
    );
  }

  addLikesToNotification() async {
    bool isNotMe = currentUserId() != widget.post!.ownerId;

    if (isNotMe) {
      DocumentSnapshot doc = await usersRef.doc(currentUserId()).get();
      user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
      notificationRef
          .doc(widget.post!.ownerId)
          .collection('notifications')
          .doc(widget.post!.postId)
          .set({
        "type": "like",
        "username": user!.username!,
        "userId": currentUserId(),
        "userDp": user!.photoUrl!,
        "postId": widget.post!.postId,
        "mediaUrl": widget.post!.mediaUrl,
        "timestamp": timestamp,
      });
    }
  }

  removeLikeFromNotification() async {
    bool isNotMe = currentUserId() != widget.post!.ownerId;

    if (isNotMe) {
      DocumentSnapshot doc = await usersRef.doc(currentUserId()).get();
      user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
      notificationRef
          .doc(widget.post!.ownerId)
          .collection('notifications')
          .doc(widget.post!.postId)
          .get()
          .then((doc) => {
                if (doc.exists) {doc.reference.delete()}
              });
    }
  }
}

showProfile(BuildContext context, {String? profileId}) {
  Navigator.push(
    context,
    CupertinoPageRoute(
      builder: (_) => Profile(profileId: profileId),
    ),
  );
}

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;
  final int minLines;
  final TextStyle style;
  final String expandText;
  final String collapseText;
  final Color linkColor;
  final VoidCallback? onExpand;
  final VoidCallback? onCollapse;

  ExpandableText({
    required this.text,
    required this.maxLines,
    required this.minLines,
    required this.style,
    required this.expandText,
    required this.collapseText,
    required this.linkColor,
    this.onExpand,
    this.onCollapse,
  });

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          widget.text,
          maxLines: _isExpanded ? null : widget.maxLines,
          overflow: TextOverflow.ellipsis,
          style: widget.style,
        ),
        InkWell(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
            if (_isExpanded) {
              widget.onExpand?.call();
            } else {
              widget.onCollapse?.call();
            }
          },
          child: Text(
            _isExpanded ? widget.collapseText : widget.expandText,
            style: TextStyle(
              color: widget.linkColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

}
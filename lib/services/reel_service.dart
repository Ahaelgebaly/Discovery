import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:discovery/models/user.dart';
import 'package:discovery/screens/view_image.dart';
import 'package:discovery/services/services.dart';
import 'package:discovery/utils/firebase.dart';
import 'package:uuid/uuid.dart';

class ReelService extends Service {
  String reelId = Uuid().v4();



//uploads post to the post collection
  uploadReel(File image, String location, String description) async {
    String link = await uploadImage(reels, image);
    DocumentSnapshot doc =
    await usersRef.doc(firebaseAuth.currentUser!.uid).get();
    user = UserModel.fromJson(
      doc.data() as Map<String, dynamic>,
    );
    var ref = reelRef.doc();
    ref.set({
      "id": ref.id,
      "reelId": ref.id,
      "username": user!.username,
      "ownerId": firebaseAuth.currentUser!.uid,
      "videoUrl": link,
      "description": description ?? "",
      "location": location ?? "",
      "timestamp": Timestamp.now(),
    }).catchError((e) {
      print(e);
    });
  }

//upload a comment
  uploadComment(String currentUserId, String comment, String reelId,
      String ownerId, String mediaUrl) async {
    DocumentSnapshot doc = await usersRef.doc(currentUserId).get();
    user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
    await commentRef.doc(reelId).collection("comments").add({
      "username": user!.username,
      "comment": comment,
      "timestamp": Timestamp.now(),
      "userDp": user!.photoUrl,
      "userId": user!.id,
    });
    bool isNotMe = ownerId != currentUserId;
    if (isNotMe) {
      addCommentToNotification("comment", comment, user!.username!, user!.id!,
          reelId, mediaUrl, ownerId, user!.photoUrl!);
    }
  }

//add the comment to notification collection
  addCommentToNotification(
      String type,
      String commentData,
      String username,
      String userId,
      String reelId,
      String videoUrl,
      String ownerId,
      String userDp) async {
    await notificationRef.doc(ownerId).collection('notifications').add({
      "type": type,
      "commentData": commentData,
      "username": username,
      "userId": userId,
      "userDp": userDp,
      "reelId": reelId,
      "videoUrl": videoUrl,
      "timestamp": Timestamp.now(),
    });
  }

//add the likes to the notfication collection
  addLikesToNotification(String type, String username, String userId,
      String reelId, String videoUrl, String ownerId, String userDp) async {
    await notificationRef
        .doc(ownerId)
        .collection('notifications')
        .doc(reelId)
        .set({
      "type": type,
      "username": username,
      "userId": firebaseAuth.currentUser!.uid,
      "userDp": userDp,
      "reelId": reelId,
      "videoUrl": videoUrl,
      "timestamp": Timestamp.now(),
    });
  }

  //remove likes from notification
  removeLikeFromNotification(
      String ownerId, String reelId, String currentUser) async {
    bool isNotMe = currentUser != ownerId;

    if (isNotMe) {
      DocumentSnapshot doc = await usersRef.doc(currentUser).get();
      user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
      notificationRef
          .doc(ownerId)
          .collection('notifications')
          .doc(reelId)
          .get()
          .then((doc) => {
        if (doc.exists) {doc.reference.delete()}
      });
    }
  }
}

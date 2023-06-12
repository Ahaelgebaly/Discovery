import 'package:cloud_firestore/cloud_firestore.dart';

class TripModel {
  String? id;
  String? postId;
  String? ownerId;
  String? username;
  String? location;
  String? caption;
  double? rating;
  String? description;
  String? howToGetThere;
  String? mediaUrl;
  Timestamp? timestamp;

  TripModel(
      {this.id,
        this.postId,
        this.ownerId,
        this.caption,
        this.location,
        this.description,
        this.howToGetThere,
        this.mediaUrl,
        this.username,
        this.timestamp,
        this.rating});


  TripModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['postId'];
    ownerId = json['ownerId'];
    location = json['location'];
    username = json['username'];
    description = json['description'];
    rating = json['rating'];
    caption = json['caption'];
    howToGetThere = json['howToGetThere'];
    mediaUrl = json['mediaUrl'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['postId'] = this.postId;
    data['ownerId'] = this.ownerId;
    data['location'] = this.location;
    data['description'] = this.description;
    data['caption'] = this.caption;
    data['howToGetThere'] = this.howToGetThere;
    data['mediaUrl'] = this.mediaUrl;
    data['rating'] = this.rating;
    data['timestamp'] = this.timestamp;
    data['username'] = this.username;
    return data;
  }
}

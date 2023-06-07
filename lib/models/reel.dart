import 'package:cloud_firestore/cloud_firestore.dart';

class ReelModel {
  String? id;
  String? reelId;
  String? ownerId;
  String? username;
  String? location;
  String? description;
  String? videoUrl;
  Timestamp? timestamp;


  ReelModel({
    this.id,
    this.reelId,
    this.ownerId,
    this.location,
    this.description,
    this.videoUrl,
    this.username,
    this.timestamp,
  });
  ReelModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reelId = json['reelId'];
    ownerId = json['ownerId'];
    location = json['location'];
    username= json['username'];
    description = json['description'];
    videoUrl = json['videoUrl'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reelId'] = this.reelId;
    data['ownerId'] = this.ownerId;
    data['location'] = this.location;
    data['description'] = this.description;
    data['videoUrl'] = this.videoUrl;

    data['timestamp'] = this.timestamp;
    data['username'] = this.username;
    return data;
  }
}

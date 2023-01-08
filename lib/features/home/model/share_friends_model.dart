import 'package:cloud_firestore/cloud_firestore.dart';

class ShareFriendsModel {
  String? audioUrl;
  String? createdAt;
  String? updatedAt;
  String? country;
  String? thumbnail;
  String? description;
  int? likes;
  String? name;
  String? status;
  String? file;
  String? title;
  String? url;
  String? docId;
  int? id;

  ShareFriendsModel({
    this.audioUrl,
    this.createdAt,
    this.country,
    this.thumbnail,
    this.updatedAt,
    this.description,
    this.name,
    this.likes,
    this.status,
    this.file,
    this.title,
    this.url,
  });

  ShareFriendsModel.fromMap(Map<String, dynamic> jsonMap) {
    audioUrl = jsonMap['audioUrl'];
    createdAt = jsonMap['createdAt'].toString();
    country = jsonMap['country'];
    thumbnail = jsonMap['thumbnail'];
    updatedAt = jsonMap['updatedAt'].toString();
    description = jsonMap['description'];
    likes = jsonMap['likes'];
    name = jsonMap['name'];
    status = jsonMap['status'];
    title = jsonMap['title'];
    url = jsonMap['url'];
    file = jsonMap['file'];
  }

  Map<String, dynamic> toMap() {
    return {
      "audioUrl": audioUrl,
      "createdAt": createdAt == null ? null : DateTime.parse(createdAt!),
      "country": country,
      "thumbnail": thumbnail,
      "updatedAt": updatedAt == null ? null : DateTime.parse(updatedAt!),
      "description": description,
      "likes": likes,
      "name": name,
      "status": status,
      "title": title,
      "url": url,
      "file": file,
    };
  }

  Map<String, dynamic> toMapDB() {
    return {
      "audioUrl": audioUrl,
      "createdAt": createdAt,
      "country": country,
      "thumbnail": thumbnail,
      "updatedAt": updatedAt,
      "description": description,
      "likes": likes,
      "name": name,
      "status": status,
      "title": title,
      "url": url,
      "file": file,
    };
  }

  ShareFriendsModel.fromQueryDocSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    docId = doc.id;
    Map<String, dynamic> data = doc.data();
    if (data['audioUrl'] != null) {
      audioUrl = doc['audioUrl'];
    }
    if (data['createdAt'] != null) {
      createdAt = data['createdAt'].toString();
    }
    if (data['country'] != null) {
      country = data['country'];
    }
    if (data['thumbnail'] != null) {
      thumbnail = data['thumbnail'];
    }
    if (data['updatedAt'] != null) {
      updatedAt = data['updatedAt'].toString();
    }
    if (data['description'] != null) {
      description = data['description'].toString();
    }

    if (data['likes'] != null) {
      likes = int.parse(data['likes'].toString());
    }
    if (data['name'] != null) {
      name = data['name'].toString();
    }

    if (data['status'] != null) {
      status = data['status'].toString();
    }

    if (data['title'] != null) {
      title = data['title'].toString();
    }
    if (data['url'] != null) {
      url = data['url'].toString();
    }
    if (data['file'] != null) {
      file = data['file'].toString();
    }
  }
}

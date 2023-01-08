import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class PhotoFriendsModel {
  String? country;
  String? createdAt;
  String? updatedAt;
  String? file;
  int? likes;
  String? status;
  String? name;
  String? docId;
  int? id;

  PhotoFriendsModel({
    this.createdAt,
    this.country,
    this.updatedAt,
    this.file,
    this.name,
    this.status,
    this.likes,
  });

  PhotoFriendsModel.fromMap(Map<String, dynamic> jsonMap) {
    createdAt = jsonMap['createdAt'].toString();
    country = jsonMap['country'];
    updatedAt = jsonMap['updatedAt'].toString();
    file = jsonMap['file'];
    likes = jsonMap['likes'];
    name = jsonMap['name'];
    status = jsonMap['status'];
    id = jsonMap['id'];
  }

  Map<String, dynamic> toMap() {
    return {
      'createdAt': createdAt == null ? null : DateTime.parse(createdAt!),
      'country': country,
      'updatedAt': updatedAt == null ? null : DateTime.parse(updatedAt!),
      'file': file,
      'likes': likes,
      'name': name,
      'status': status,
    };
  }

  Map<String, dynamic> toMapDB() {
    return {
      'createdAt': createdAt,
      'country': country,
      'updatedAt': updatedAt,
      'file': file,
      'likes': likes,
      'name': name,
      'status': status,
    };
  }

  PhotoFriendsModel.fromQueryDocSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    this.docId = doc.id;
    Map<String, dynamic> data = doc.data();

    if (data['createdAt'] != null) {
      createdAt = data['createdAt'].toString();
    }
    if (data['country'] != null) {
      country = data['country'];
    }

    if (data['updatedAt'] != null) {
      updatedAt = data['updatedAt'].toString();
    }

    if (data['file'] != null) {
      file = data['file'].toString();
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
  }
}

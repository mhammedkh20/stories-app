import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ReportStoriesModel {
  String? details;
  String? createdAt;
  String? updatedAt;
  String? storyId;
  String? storyTitle;
  String? type;
  String? username;
  String? docId;
  int? id;

  ReportStoriesModel({
    this.createdAt,
    this.details,
    this.updatedAt,
    this.storyId,
    this.username,
    this.type,
    this.storyTitle,
  });

  ReportStoriesModel.fromMap(Map<String, dynamic> jsonMap) {
    createdAt = jsonMap['createdAt'].toString();
    details = jsonMap['details'];
    updatedAt = jsonMap['updatedAt'];
    storyId = jsonMap['storyId'];
    storyTitle = jsonMap['storyTitle'];
    username = jsonMap['username'];
    type = jsonMap['type'];
    id = jsonMap['id'];
  }

  Map<String, dynamic> toMap() {
    return {
      'createdAt': createdAt == null ? null : DateTime.parse(createdAt!),
      'details': details,
      'updatedAt': updatedAt == null ? null : DateTime.parse(updatedAt!),
      'storyId': storyId,
      'storyTitle': storyTitle,
      'username': username,
      'type': type,
    };
  }

  ReportStoriesModel.fromQueryDocSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    this.docId = doc.id;
    Map<String, dynamic> data = doc.data();

    if (data['createdAt'] != null) {
      createdAt = data['createdAt'].toString();
    }
    if (data['details'] != null) {
      details = data['details'];
    }

    if (data['updatedAt'] != null) {
      updatedAt = data['updatedAt'].toString();
    }

    if (data['storyId'] != null) {
      storyId = data['storyId'];
    }
    if (data['storyTitle'] != null) {
      storyTitle = data['storyTitle'];
    }
    if (data['username'] != null) {
      username = data['username'];
    }

    if (data['type'] != null) {
      type = data['type'];
    }
  }
}

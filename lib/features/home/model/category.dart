import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:stories_app/features/home/model/story.dart';

class Category {
  int? id;
  int? count;
  String? createdAt;
  String? name;
  String? thumbnail;
  String? updatedAt;
  List<Story>? listStories;
  String? docId;

  Category({
    this.count,
    this.createdAt,
    this.name,
    this.thumbnail,
    this.updatedAt,
  });

  Category.fromMap(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    count = jsonMap['count'];
    createdAt = jsonMap['createdAt'].toString();
    name = jsonMap['name'];
    thumbnail = jsonMap['thumbnail'];
    updatedAt = jsonMap['updatedAt'];
  }
  Category.fromMapFromFirestore(Map<String, dynamic> jsonMap) {
    docId = jsonMap['docId'];
    count = jsonMap['count'];
    createdAt = jsonMap['createdAt'].toString();
    name = jsonMap['name'];
    thumbnail = jsonMap['thumbnail'];
    updatedAt = jsonMap['updatedAt'];
  }

  Map<String, dynamic> toMap() {
    return {
      'count': count,
      'createdAt': createdAt,
      'name': name,
      'thumbnail': thumbnail,
      'updatedAt': updatedAt,
    };
  }

  Category.fromQueryDocSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    docId = doc.id;
    Map<String, dynamic> data = doc.data();

    if (data['count'] != null) {
      count = doc['count'];
    }
    if (data['createdAt'] != null) {
      createdAt = data['createdAt'].toString();
    }
    if (data['name'] != null) {
      name = data['name'];
    }
    if (data['thumbnail'] != null) {
      thumbnail = data['thumbnail'];
    }
    if (data['updatedAt'] != null) {
      updatedAt = data['updatedAt'].toString();
    }
  }
}

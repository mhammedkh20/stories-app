import 'package:cloud_firestore/cloud_firestore.dart';

class Story {
  int? id;
  int? idCategory;
  String? audioUrl;
  String? createdAt;
  String? description;
  int? likes;
  String? thumbnail;
  String? title;
  String? updatedAt;
  String? url;
  bool? isMove;
  bool? show;
  List<dynamic>? otherImages;
  String? docId;
  String? okvideo;
  String? url2;
  String? audioUrl2;

  Story();

  Story.fromMap(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    audioUrl = jsonMap['audioUrl'];
    createdAt = jsonMap['createdAt'].toString();
    description = jsonMap['description'];
    likes = jsonMap['likes'];
    thumbnail = jsonMap['thumbnail'];
    title = jsonMap['title'];
    updatedAt = jsonMap['updatedAt'].toString();
    url = jsonMap['url'];
    isMove = jsonMap['isMove'] == 1;
    show = jsonMap['show'] == 1;
    okvideo = jsonMap['okvideo'];
  }

  Story.fromQueryDocSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    docId = doc.id;
    Map<String, dynamic> data = doc.data();
    if (data['audioUrl'] != null) {
      audioUrl = data['audioUrl'];
      audioUrl2 = data['audioUrl'];
    }
    if (data['createdAt'] != null) {
      createdAt = data['createdAt'].toString();
    }
    if (data['description'] != null) {
      description = data['description'];
    }
    if (data['likes'] != null) {
      likes = data['likes'];
    }
    if (data['thumbnail'] != null) {
      thumbnail = data['thumbnail'];
    }
    if (data['title'] != null) {
      title = data['title'];
    }
    if (data['updatedAt'] != null) {
      updatedAt = data['updatedAt'].toString();
    }
    if (data['url'] != null) {
      url = data['url'];
      url2 = data['url'];
    }
    if (data['okvideo'] != null) {
      okvideo = data['okvideo'];
    }
    if (data['otherImages'] != null) {
      otherImages = data['otherImages'];
    }
    if (data['isMove'] != null) {
      isMove = data['isMove'];
    }
    if (data['show'] != null) {
      show = data['show'];
    }
  }

  // ? database
  Story.fromMapForCategoryId(Map<String, dynamic> jsonMap) {
    idCategory = jsonMap['idCategory'];
    id = jsonMap['id'];
    audioUrl = jsonMap['audioUrl'];
    createdAt = jsonMap['createdAt'].toString();
    description = jsonMap['description'];
    likes = jsonMap['likes'];
    thumbnail = jsonMap['thumbnail'];
    title = jsonMap['title'];
    updatedAt = jsonMap['updatedAt'].toString();
    url = jsonMap['url'];
    isMove = jsonMap['isMove'] == 1;
    show = jsonMap['show'] == 1;
    okvideo = jsonMap['okvideo'];
    url2 = jsonMap['url2'];
    audioUrl2 = jsonMap['audioUrl2'];
  }
  // ?  database
  Map<String, dynamic> toMapForCategoryId() {
    return {
      'idCategory': idCategory,
      // 'audioUrl': audioUrl,
      'createdAt': createdAt,
      'description': description,
      'likes': likes,
      'thumbnail': thumbnail,
      'title': title,
      'updatedAt': updatedAt,
      // 'url': url,
      'isMove': isMove,
      'show': show,
      'okvideo': okvideo,
      'url2': url2,
      'audioUrl2': audioUrl2,
    };
  }

  Map<String, dynamic> toMapDBFilm() {
    return {
      'audioUrl': audioUrl,
      'createdAt': createdAt,
      'description': description,
      'likes': likes,
      'thumbnail': thumbnail,
      'title': title,
      'updatedAt': updatedAt,
      'url': url,
      'isMove': isMove,
      'show': show,
      'okvideo': okvideo,
    };
  }
}

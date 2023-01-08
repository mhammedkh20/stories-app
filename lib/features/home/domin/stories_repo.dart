import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stories_app/features/home/model/category.dart';
import 'package:stories_app/features/home/model/share_friends_model.dart';
import 'package:stories_app/features/home/model/story.dart';

abstract class StoriesRepo {
  Future<Story?> getMovieOfTheWeek();

  Future<List<Category>?> getCategories();

  Future<bool> updateLikesStory(String categoryId, String docId, int like);
  Future<bool> updateLikesFilm(int like);
}

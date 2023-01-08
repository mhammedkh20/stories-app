import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stories_app/features/home/data/stories_repo_imp.dart';
import 'package:stories_app/features/home/model/category.dart';
import 'package:stories_app/features/home/model/story.dart';

part 'story_state.dart';

class StoryCubit extends Cubit<StoryState> {
  List<Category>? listCategories = [];

  Story? movieOfTheWeek = null;

  bool loadingFilem = true;

  bool loadingCategories = true;

  bool clickItemFilmMove = false;

  int selectedItemCategory = 0;

  int indexPageViewImages = 0;

  final _storyRepoImp = StoriesRepoImp();

  StoryCubit() : super(StoryInitial());

  static StoryCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  onChangePageView(int index) async {
    indexPageViewImages = index;
    emit(StoryInitial());
  }

  onClickItemFilmMove() async {
    clickItemFilmMove = !clickItemFilmMove;
    emit(OnClickItemFilmMove(clickItemFilmMove));
  }

  onClickItemCategory(int index) async {
    selectedItemCategory = index;
    emit(OnClickItemCategory(selectedItemCategory));
  }

  getMoveOfTheWeek() async {
    movieOfTheWeek = await _storyRepoImp.getMovieOfTheWeek();
    loadingFilem = false;
    emit(StoryMoveOfTheWeek(movieOfTheWeek));
  }

  getCategories() async {
    listCategories = await _storyRepoImp.getCategories();
    loadingCategories = false;
    emit(StoryMoveOfTheWeek(movieOfTheWeek));
  }

  updateLikeStory({
    required String categoryId,
    required int indexCategory,
    required int indexStory,
  }) async {
    listCategories![indexCategory].listStories![indexStory].likes =
        listCategories![indexCategory].listStories![indexStory].likes! + 1;

    await _storyRepoImp.updateLikesStory(
        categoryId,
        listCategories![indexCategory].listStories![indexStory].docId!,
        listCategories![indexCategory].listStories![indexStory].likes!);

    emit(UpdateLikeStory());
  }

  updateLikeMove() async {
    if (movieOfTheWeek != null) {
      movieOfTheWeek!.likes = movieOfTheWeek!.likes! + 1;
    }

    await _storyRepoImp.updateLikesFilm(movieOfTheWeek!.likes ?? 0);

    emit(StoryMoveOfTheWeek(movieOfTheWeek));
  }
}

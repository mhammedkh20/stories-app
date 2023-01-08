part of 'story_cubit.dart';

@immutable
abstract class StoryState {}

class StoryInitial extends StoryState {}

class StoryMoveOfTheWeek extends StoryState {
  final Story? move;
  StoryMoveOfTheWeek(this.move);
}

class OnClickItemFilmMove extends StoryState {
  final bool? onClick;
  OnClickItemFilmMove(this.onClick);
}

class OnClickItemCategory extends StoryState {
  final int index;
  OnClickItemCategory(this.index);
}

class GetCategories extends StoryState {
  final List<Category> listCategories;
  GetCategories(this.listCategories);
}

class UpdateLikeStory extends StoryState {}

import 'package:hacker_news/model/story.dart';
import 'package:meta/meta.dart';

@immutable
abstract class StoryCommentsEvent {}

@immutable
class SelectStory extends StoryCommentsEvent {

  final Story story;

  SelectStory({
    @required this.story,
  });

}

@immutable
class RequestMoreComments extends StoryCommentsEvent {}

@immutable
class ClearStorySelection extends StoryCommentsEvent {}

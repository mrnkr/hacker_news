import 'package:hacker_news/model/comment.dart';
import 'package:hacker_news/model/story.dart';
import 'package:meta/meta.dart';

@immutable
class StoryCommentsState {
  final bool isLoading;
  final Story story;
  final List<Comment> comments;
  final int lastDownloadedPage;

  StoryCommentsState({
    this.isLoading = false,
    this.story,
    comments,
    this.lastDownloadedPage = -1,
  }) : comments = comments ?? <Comment>[];

  StoryCommentsState startLoading() {
    return StoryCommentsState(
      isLoading: true,
      story: story,
      comments: comments,
      lastDownloadedPage: lastDownloadedPage);
  }

  StoryCommentsState selectStory(Story s) {
    return StoryCommentsState(isLoading: isLoading, story: s);
  }

  StoryCommentsState loadComments(List<Comment> comms, int page) {
    return StoryCommentsState(
      isLoading: false,
      story: story,
      comments: [...comments, ...comms],
      lastDownloadedPage: page);
  }

  StoryCommentsState clearSelection() {
    return StoryCommentsState();
  }

  int selectCommentLevel(Comment comment) {
    var idx = comments.indexWhere((c) => c.id == comment.parent);
    
    if (idx == -1) {
      return 1;
    } else {
      return 1 + selectCommentLevel(comments[idx]);
    }
  }
}

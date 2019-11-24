import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hacker_news/model/comment.dart';
import 'package:hacker_news/services/services.dart';
import './bloc.dart';

class StoryCommentsBloc extends Bloc<StoryCommentsEvent, StoryCommentsState> {
  final pageLen = 15;
  final itemsService = GetIt.instance.get<ItemsService>();

  @override
  StoryCommentsState get initialState => StoryCommentsState();

  @override
  Stream<StoryCommentsState> mapEventToState(StoryCommentsEvent e) async* {
    if (e is SelectStory) {
      yield state.selectStory(e.story);
      add(RequestMoreComments());
    }

    if (e is RequestMoreComments) {
      yield state.startLoading();

      var page = state.lastDownloadedPage + 1;
      var offset = pageLen * page;
      var limit = state.story.commentIds.length;

      if (offset >= limit) {
        return;
      }

      var commentIds = state.story.commentIds
          .sublist(offset, offset + pageLen >= limit ? limit - 1 : offset + pageLen);
      var comments = (await Future.wait(
          commentIds.map((id) => _getCommentsRecursive(id)),
          eagerError: true)).fold<List<Comment>>([], (acum, cur) => [...acum, ...cur]);

      yield state.loadComments(comments, page);
    }

    if (e is ClearStorySelection) {
      yield state.clearSelection();
    }
  }

  Future<List<Comment>> _getCommentsRecursive(int id) async {
    var comment = (await itemsService.getById(id)).body as Comment;

    if (comment != null && comment.body != null) {
      if (comment.children != null) {
        var comments = await Future.wait(
            comment.children.map((id) => _getCommentsRecursive(id)));
        return comments.fold<List<Comment>>([comment], (acum, cur) => [...acum, ...cur]);
      }

      return [comment];
    }

    return [];
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hacker_news/bloc/bloc.dart';
import 'package:hacker_news/pages/story_comments/comment_row.dart';

class StoryComments extends StatelessWidget {
  final ScrollController controller;
  final storyCommentsBloc = GetIt.instance<StoryCommentsBloc>();

  StoryComments() : controller = ScrollController() {
    controller.addListener(onScroll);
  }

  void onScroll() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      storyCommentsBloc.add(RequestMoreComments());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: storyCommentsBloc,
      builder: (ctx, StoryCommentsState state) {
        var content;

        if (state.isLoading && state.comments.length == 0) {
          content = Center(
            child: CupertinoActivityIndicator(),
          );
        } else {
          content = SafeArea(
            child: ListView.builder(
              controller: controller,
              itemCount: state.comments.length,
              padding: EdgeInsets.all(8),
              itemBuilder: (ctx, idx) => CommentRow(
                  comment: state.comments[idx],
                  level: state.selectCommentLevel(state.comments[idx])),
            ),
          );
        }

        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            leading: GestureDetector(
              child: Icon(CupertinoIcons.back),
              onTap: () => Navigator.of(context).pop(),
            ),
            middle: Text(
              state.story.title,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          child: content,
        );
      },
    );
  }
}

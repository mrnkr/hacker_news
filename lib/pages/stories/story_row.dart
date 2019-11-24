import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:hacker_news/bloc/bloc.dart';
import 'package:hacker_news/model/story.dart';
import 'package:hacker_news/pages/story_comments.dart';

class StoryRow extends StatelessWidget {
  final Story story;
  final storyCommentsBloc = GetIt.instance.get<StoryCommentsBloc>();

  StoryRow({
    @required this.story,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => gotoStory(context),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                story.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Text('${story.score} points'),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Text('By: ${story.author}'),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Text('${story.commentCount ?? 0} comments'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void gotoStory(BuildContext ctx) {
    if (story.commentCount == 0) {
      return;
    }
    
    storyCommentsBloc.add(SelectStory(story: story));
    Navigator.of(ctx).push(
      CupertinoPageRoute(builder: (ctx) => StoryComments()),
    );
  }
}

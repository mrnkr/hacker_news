import 'package:flutter/cupertino.dart';
import 'package:hacker_news/model/comment.dart';

class CommentRow extends StatelessWidget {
  final Comment comment;
  final int level;

  CommentRow({
    @required this.comment,
    this.level = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 8, right: 8, bottom: 8, left: (level * 16).toDouble()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8, right: 16),
                child: Text(
                  comment.author,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                  '${comment.createdAt.month}/${comment.createdAt.day}/${comment.createdAt.year}')
            ],
          ),
          Text(comment.body
              .replaceAll(RegExp(r'(<(\/?)[ a-zA-Z0-9=":]+>)'), '')
              .replaceAll(RegExp(r'&(#?)[a-zA-Z0-9]+;'), '')),
        ],
      ),
    );
  }
}

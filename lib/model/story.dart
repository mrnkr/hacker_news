import 'package:hacker_news/model/item.dart';
import 'package:meta/meta.dart';

@immutable
class Story extends Item {
  final String title;
  final int commentCount;
  final List<int> commentIds;
  final int score;

  Story.fromJson(Map data)
      : title = data['title'],
        commentCount = data['descendants'],
        commentIds =
            (data['kids'] as List<dynamic> ?? []).map((e) => e as int).toList(),
        score = data['score'],
        super(id: data['id'], author: data['by'], timestamp: data['time']);
}

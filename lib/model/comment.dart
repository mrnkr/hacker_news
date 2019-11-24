import 'package:hacker_news/model/item.dart';
import 'package:meta/meta.dart';

@immutable
class Comment extends Item {
  final String body;
  final int parent;
  final List<int> children;

  Comment.fromJson(Map data)
      : body = data['text'],
        parent = data['parent'],
        children = (data['kids'] as List<dynamic> ?? []).map((e) => e as int).toList(),
        super(id: data['id'], author: data['by'], timestamp: data['time']);
}

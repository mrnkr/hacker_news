import 'package:hacker_news/model/story.dart';
import 'package:meta/meta.dart';

@immutable
class Poll extends Story {
  final List<int> parts;

  Poll.fromJson(Map data)
    : parts = (data['parts'] as List<dynamic> ?? []).map((e) => e as int).toList(),
      super.fromJson(data);
}
import 'package:hacker_news/model/story.dart';
import 'package:meta/meta.dart';

@immutable
class Job extends Story {
  final String text;
  
  Job.fromJson(Map data)
    : text = data['text'],
      super.fromJson(data);
}
import 'package:chopper/chopper.dart';
import 'package:hacker_news/model/comment.dart';
import 'package:hacker_news/model/job.dart';
import 'package:hacker_news/model/poll.dart';
import 'package:hacker_news/model/story.dart';

class ItemsConverter extends JsonConverter {

  @override
  Response<Body> convertResponse<Body, Single>(Response res) {
    final Response raw = super.convertResponse(res);
    final Body body = _deserializeBody<Single>(raw.body);
    return raw.replace<Body>(body: body);
  }

  dynamic _deserializeBody<T>(dynamic body) {
    if (body is T) return body;

    if (body is List)
      return _deserializeListOf<T>(body);
    else
      return _deserialize<T>(body);
  }

  List<T> _deserializeListOf<T>(List l) {
    return [ ...l.map((e) => _deserialize<T>(e)) ];
  }

  T _deserialize<T>(Map e) {
    T ret;

    switch (e['type']) {
      case 'story':
        ret = Story.fromJson(e) as T;
        break;
      case 'comment':
        ret = Comment.fromJson(e) as T;
        break;
      case 'job':
        ret = Job.fromJson(e) as T;
        break;
      case 'poll':
        ret = Poll.fromJson(e) as T;
        break;
    }

    return ret;
  }

}

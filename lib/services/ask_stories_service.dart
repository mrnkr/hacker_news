import "dart:async";
import 'package:chopper/chopper.dart';
import 'package:hacker_news/services/stories_service.dart';

part "ask_stories_service.chopper.dart";

@ChopperApi(baseUrl: '/askstories.json')
abstract class AskStoriesService extends ChopperService implements StoriesService {
  @Get()
  Future<Response<List<int>>> getIds();

  static AskStoriesService create() {
    final client = ChopperClient(
      baseUrl: 'https://hacker-news.firebaseio.com/v0',
      services: [
        _$AskStoriesService(),
      ],
      converter: JsonConverter(),
      interceptors: [
        HttpLoggingInterceptor(),
      ],
    );

    return _$AskStoriesService(client);
  }
}

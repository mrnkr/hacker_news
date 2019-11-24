import "dart:async";
import 'package:chopper/chopper.dart';
import 'package:hacker_news/services/stories_service.dart';

part "top_stories_service.chopper.dart";

@ChopperApi(baseUrl: '/topstories.json')
abstract class TopStoriesService extends ChopperService implements StoriesService {

  @Get()
  Future<Response<List<int>>> getIds();

  static TopStoriesService create() {
    final client = ChopperClient(
      baseUrl: 'https://hacker-news.firebaseio.com/v0',
      services: [
        _$TopStoriesService(),
      ],
      converter: JsonConverter(),
      interceptors: [
        HttpLoggingInterceptor(),
      ],
    );

    return _$TopStoriesService(client);
  }

}

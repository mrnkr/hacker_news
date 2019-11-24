import "dart:async";
import 'package:chopper/chopper.dart';
import 'package:hacker_news/services/stories_service.dart';

part "latest_stories_service.chopper.dart";

@ChopperApi(baseUrl: '/newstories.json')
abstract class LatestStoriesService extends ChopperService implements StoriesService {

  @Get()
  Future<Response<List<int>>> getIds();

  static LatestStoriesService create() {
    final client = ChopperClient(
      baseUrl: 'https://hacker-news.firebaseio.com/v0',
      services: [
        _$LatestStoriesService(),
      ],
      converter: JsonConverter(),
      interceptors: [
        HttpLoggingInterceptor(),
      ],
    );

    return _$LatestStoriesService(client);
  }

}

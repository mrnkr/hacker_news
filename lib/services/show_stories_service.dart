import "dart:async";
import 'package:chopper/chopper.dart';
import 'package:hacker_news/services/stories_service.dart';

part "show_stories_service.chopper.dart";

@ChopperApi(baseUrl: '/showstories.json')
abstract class ShowStoriesService extends ChopperService implements StoriesService {

  @Get()
  Future<Response<List<int>>> getIds();

  static ShowStoriesService create() {
    final client = ChopperClient(
      baseUrl: 'https://hacker-news.firebaseio.com/v0',
      services: [
        _$ShowStoriesService(),
      ],
      converter: JsonConverter(),
      interceptors: [
        HttpLoggingInterceptor(),
      ],
    );

    return _$ShowStoriesService(client);
  }

}

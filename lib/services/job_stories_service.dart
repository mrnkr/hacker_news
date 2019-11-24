import "dart:async";
import 'package:chopper/chopper.dart';
import 'package:hacker_news/services/stories_service.dart';

part "job_stories_service.chopper.dart";

@ChopperApi(baseUrl: '/jobstories.json')
abstract class JobStoriesService extends ChopperService implements StoriesService {

  @Get()
  Future<Response<List<int>>> getIds();

  static JobStoriesService create() {
    final client = ChopperClient(
      baseUrl: 'https://hacker-news.firebaseio.com/v0',
      services: [
        _$JobStoriesService(),
      ],
      converter: JsonConverter(),
      interceptors: [
        HttpLoggingInterceptor(),
      ],
    );

    return _$JobStoriesService(client);
  }

}

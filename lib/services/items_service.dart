import "dart:async";
import 'package:chopper/chopper.dart';
import 'package:hacker_news/model/item.dart';
import 'package:hacker_news/services/items_converter.dart';

part "items_service.chopper.dart";

@ChopperApi(baseUrl: '/item')
abstract class ItemsService extends ChopperService {

  @Get(path: '{id}.json')
  Future<Response<Item>> getById(@Path() int id);

  static ItemsService create() {
    final client = ChopperClient(
      baseUrl: 'https://hacker-news.firebaseio.com/v0',
      services: [
        _$ItemsService(),
      ],
      converter: ItemsConverter(),
      interceptors: [
        HttpLoggingInterceptor(),
      ],
    );

    return _$ItemsService(client);
  }

}

import 'package:chopper/chopper.dart';

abstract class StoriesService {
  Future<Response<List<int>>> getIds();
}

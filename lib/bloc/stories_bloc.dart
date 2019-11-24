import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hacker_news/model/story.dart';
import 'package:hacker_news/services/items_service.dart';
import 'package:hacker_news/services/stories_service.dart';
import 'package:meta/meta.dart';
import './bloc.dart';

class StoriesBloc<T extends StoriesService> extends Bloc<StoriesEvent, StoriesState> {
  final pageLen = 15;
  final itemsService = GetIt.instance.get<ItemsService>();
  final T storiesService;

  StoriesBloc({
    @required this.storiesService,
  });

  factory StoriesBloc.init({T storiesService}) =>
      StoriesBloc(storiesService: storiesService)..add(RequestStories());

  @override
  StoriesState get initialState => StoriesState();

  @override
  Stream<StoriesState> mapEventToState(StoriesEvent e) async* {
    if (e is RequestStories) {
      yield state.startLoading();

      if (state.ids.length == 0) {
        var ids = (await storiesService.getIds()).body;
        yield state.loadIds(ids);
      }

      var page = state.lastDownloadedPage + 1;
      var offset = pageLen * page;
      var limit = state.ids.length;

      if (offset >= limit) {
        return;
      }

      var pageIds = state.ids.sublist(
          offset, offset + pageLen >= limit ? limit - 1 : offset + pageLen);
      var stories = await Future.wait(
        pageIds
            .map((id) async => (await itemsService.getById(id)).body as Story),
        eagerError: true,
      );

      yield state.loadStories(stories, page);
    }
  }
}

import 'package:hacker_news/model/story.dart';
import 'package:meta/meta.dart';

@immutable
class StoriesState {

  final bool isLoading;
  final List<int> ids;
  final List<Story> stories;
  final int lastDownloadedPage;

  StoriesState({
    this.isLoading = false,
    ids,
    stories,
    this.lastDownloadedPage = -1,
  })  : ids = ids ?? <int>[],
        stories = stories ?? <Story>[];

  StoriesState startLoading() {
    return StoriesState(
      isLoading: true,
      ids: ids,
      stories: stories,
      lastDownloadedPage: lastDownloadedPage);
  }

  StoriesState loadIds(List<int> ids) {
    return StoriesState(
      isLoading: isLoading,
      ids: ids,
      stories: stories);
  }

  StoriesState loadStories(List<Story> newStories, int page) {
    return StoriesState(
        isLoading: false,
        ids: ids,
        stories: [...stories, ...newStories],
        lastDownloadedPage: page);
  }

}

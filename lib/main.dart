import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:hacker_news/bloc/bloc.dart';
import 'package:hacker_news/pages/stories.dart';
import 'package:get_it/get_it.dart';
import 'package:hacker_news/services/ask_stories_service.dart';
import 'package:hacker_news/services/job_stories_service.dart';
import 'package:hacker_news/services/latest_stories_service.dart';
import 'package:hacker_news/services/services.dart';
import 'package:hacker_news/services/show_stories_service.dart';

void main() {
  BlocSupervisor.delegate = MyDelegate();

  final container = GetIt.instance;
  container.registerLazySingleton(() => ItemsService.create());
  container.registerLazySingleton(
      () => StoriesBloc.init(storiesService: TopStoriesService.create()));
  container.registerLazySingleton(
      () => StoriesBloc.init(storiesService: LatestStoriesService.create()));
  container.registerLazySingleton(
      () => StoriesBloc.init(storiesService: AskStoriesService.create()));
  container.registerLazySingleton(
      () => StoriesBloc.init(storiesService: ShowStoriesService.create()));
  container.registerLazySingleton(
      () => StoriesBloc.init(storiesService: JobStoriesService.create()));
  container.registerLazySingleton(() => StoryCommentsBloc());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Hacker News',
      home: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                title: Text('Home'),
                icon: Icon(CupertinoIcons.home),
              ),
              BottomNavigationBarItem(
                title: Text('New'),
                icon: Icon(CupertinoIcons.news),
              ),
              BottomNavigationBarItem(
                  title: Text('Show'), icon: Icon(CupertinoIcons.eye)),
              BottomNavigationBarItem(
                  title: Text('Ask'), icon: Icon(CupertinoIcons.info)),
              BottomNavigationBarItem(
                  title: Text('Jobs'), icon: Icon(CupertinoIcons.bell)),
            ],
          ),
          tabBuilder: (ctx, idx) => CupertinoTabView(builder: (ctx) {
                switch (idx) {
                  case 0:
                    return Stories<StoriesBloc<TopStoriesService>>(
                        title: 'Top Stories');
                  case 1:
                    return Stories<StoriesBloc<LatestStoriesService>>(
                        title: 'Latest Stories');
                  case 2:
                    return Stories<StoriesBloc<ShowStoriesService>>(
                        title: 'Show Stories');
                  case 3:
                    return Stories<StoriesBloc<AskStoriesService>>(
                        title: 'Ask Stories');
                  case 4:
                    return Stories<StoriesBloc<JobStoriesService>>(
                        title: 'Job Stories');
                }
              })),
    );
  }
}

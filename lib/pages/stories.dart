import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hacker_news/bloc/bloc.dart';
import 'package:hacker_news/pages/stories/story_row.dart';

class Stories<T extends StoriesBloc> extends StatelessWidget {
  final ScrollController controller;
  final String title;
  final StoriesBloc storiesBloc;

  Stories({
    @required this.title,
  })
    : controller = ScrollController(),
      storiesBloc = GetIt.instance<T>() {
        controller.addListener(onScroll);
      }

  void onScroll() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      storiesBloc.add(RequestStories());
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        controller: controller,
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text(title),
          ),
          SliverSafeArea(
            top: false,
            minimum: const EdgeInsets.only(top: 8),
            sliver: BlocBuilder(
              bloc: storiesBloc,
              builder: (ctx, StoriesState state) {
                if (state.isLoading && state.stories.length == 0) {
                  return SliverFillRemaining(
                    child: CupertinoActivityIndicator(),
                  );
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate((ctx, idx) {
                    if (idx < state.stories.length) {
                      return StoryRow(story: state.stories[idx]);
                    }

                    return null;
                  }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

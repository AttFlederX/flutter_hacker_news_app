import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hacker_news_app/pages/story_page.dart';
import 'package:hacker_news_app/stores/feed/feed_store.dart';
import 'package:hacker_news_app/widgets/card_wrapper.dart';
import 'package:hacker_news_app/widgets/story_list_item.dart';
import 'package:provider/provider.dart';

class FeedList extends StatelessWidget {
  const FeedList({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<FeedStore>(context);

    return RefreshIndicator(
      onRefresh: () => store.refreshFeed(),
      child: Observer(
        builder: (context) => ListView.builder(
          itemCount: store.storyIds.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              if (store.storyCache.containsKey(store.storyIds[index])) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => StoryPage(
                      story: store.storyCache[store.storyIds[index]]!,
                    ),
                  ),
                );
              }
            },
            child: CardWrapper(
              child: _makeStoryCard(
                context,
                store,
                store.storyIds[index],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _makeStoryCard(BuildContext context, FeedStore store, int id) {
    // look up in cache
    if (store.storyCache.containsKey(id)) {
      return StoryListItem(story: store.storyCache[id]!);
    }

    // fetch from API
    return FutureBuilder(
      future: store.getStory(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // show spinner
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasError) {
            // show error
            return Center(
              child: Text(snapshot.error!.toString()),
            );
          }
        }

        return StoryListItem(story: snapshot.data!);
      },
    );
  }
}

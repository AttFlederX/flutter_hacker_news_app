import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hacker_news_app/models/story/story.dart';
import 'package:hacker_news_app/pages/story_page.dart';
import 'package:hacker_news_app/stores/feed/feed_store.dart';
import 'package:intl/intl.dart';

class FeedPage extends StatelessWidget {
  final _store = FeedStore();

  FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('HackerNews'),
      ),
      body: FutureBuilder(
        future: _store.refreshFeed(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // show spinner
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (_store.errorMessage.isNotEmpty) {
              // show error
              return Center(
                child: Text(_store.errorMessage),
              );
            }

            // show feed
            return _makeFeed(context);
          }
        },
      ),
    );
  }

  Widget _makeFeed(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _store.refreshFeed(),
      child: Observer(
        builder: (context) => ListView.builder(
          itemCount: _store.storyIds.length,
          itemBuilder: (context, index) => Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _makeStoryCard(context, _store.storyIds[index]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _makeStoryCard(BuildContext context, int id) {
    // look up in cache
    if (_store.storyCache.containsKey(id)) {
      return _makeStory(context, _store.storyCache[id]!);
    }

    // fetch from API
    return FutureBuilder(
      future: _store.getStory(id),
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
          } else if (snapshot.hasData) {
            return _makeStory(context, snapshot.data!);
          }
        }

        return const Placeholder();
      },
    );
  }

  Widget _makeStory(BuildContext context, Story story) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => StoryPage(
          story: story,
        ),
      )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // dtm
              Text(
                DateFormat('MMM d, yyyy | hh:mm').format(story.dtm),
                style: Theme.of(context).textTheme.labelSmall,
              ),

              // user
              Text(
                'by ${story.by.toString()}',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),

          // title
          Text(
            story.title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),

          const SizedBox(
            height: 8,
          ),

          // votes & comments
          Text(
            '${story.score} votes | ${story.descendants} comments',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}

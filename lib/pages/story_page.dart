import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hacker_news_app/models/story/story.dart';
import 'package:hacker_news_app/stores/story/story_store.dart';
import 'package:hacker_news_app/widgets/comment_list.dart';
import 'package:hacker_news_app/widgets/story_content.dart';

class StoryPage extends StatelessWidget {
  final _store = StoryStore();

  final Story story;

  StoryPage({super.key, required this.story}) {
    _store.setCommentIds(story.kids ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Story'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StoryContent(story: story),
                  _makeStoryStats(),
                ],
              ),
            ),
          ),
          CommentList(store: _store),
        ],
      ),
    );
  }

  _makeStoryStats() {
    // votes & comments
    return Observer(
      builder: (context) => Text(
        '${story.score} votes | ${story.descendants} comments',
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}

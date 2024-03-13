import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hacker_news_app/models/comment/comment.dart';
import 'package:hacker_news_app/models/story/story.dart';
import 'package:hacker_news_app/stores/story/story_store.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._makeStoryContent(context),

            const SizedBox(
              height: 16,
            ),

            // comments
            _makeCommentList(context),
          ],
        ),
      ),
    );
  }

  _makeStoryContent(BuildContext context) {
    return [
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

      const SizedBox(
        height: 8,
      ),

      // title
      Text(
        story.title,
        style: Theme.of(context).textTheme.headlineSmall,
      ),

      const SizedBox(
        height: 8,
      ),

      // url
      Link(
        uri: Uri.tryParse(story.url) ?? Uri.base,
        builder: (context, followLink) => InkWell(
          onTap: followLink,
          child: Text(
            story.url,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
          ),
        ),
      ),

      const SizedBox(
        height: 16,
      ),

      // votes & comments
      Text(
        '${story.score} votes | ${story.descendants} comments',
        style: Theme.of(context).textTheme.titleSmall,
      ),
    ];
  }

  _makeCommentList(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: _store.commentIds.length,
        itemBuilder: (context, index) => Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: _makeCommentCard(context, _store.commentIds[index]),
          ),
        ),
      ),
    );
  }

  _makeCommentCard(BuildContext context, int commentId) {
    // look up in cache
    if (_store.commentCache.containsKey(commentId)) {
      return _makeComment(context, _store.commentCache[commentId]!);
    }

    return FutureBuilder(
      future: _store.getComment(commentId),
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
            return _makeComment(context, snapshot.data!);
          }
        }

        return const Placeholder();
      },
    );
  }

  _makeComment(BuildContext context, Comment comment) => Column(
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

          const SizedBox(height: 8),

          // html content
          HtmlWidget(
            comment.text,
            onTapUrl: (url) => launchUrlString(url),
          ),
        ],
      );
}

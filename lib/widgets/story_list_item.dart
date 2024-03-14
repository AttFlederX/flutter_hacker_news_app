import 'package:flutter/material.dart';
import 'package:hacker_news_app/models/story/story.dart';
import 'package:intl/intl.dart';

class StoryListItem extends StatelessWidget {
  final Story story;

  const StoryListItem({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}

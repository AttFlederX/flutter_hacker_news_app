import 'package:flutter/material.dart';
import 'package:hacker_news_app/models/story/story.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/link.dart';

class StoryContent extends StatelessWidget {
  final Story story;

  const StoryContent({super.key, required this.story});

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

        const SizedBox(height: 16),

        // title
        Text(
          story.title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),

        const SizedBox(height: 16),

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
      ],
    );
  }
}

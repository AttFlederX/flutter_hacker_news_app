import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hacker_news_app/models/comment/comment.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CommentListItem extends StatelessWidget {
  final Comment comment;

  const CommentListItem({super.key, required this.comment});

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
              DateFormat('MMM d, yyyy | hh:mm').format(comment.dtm),
              style: Theme.of(context).textTheme.labelSmall,
            ),

            // user
            Text(
              'by ${comment.by.toString()}',
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
}

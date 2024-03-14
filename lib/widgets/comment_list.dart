import 'package:flutter/material.dart';
import 'package:hacker_news_app/stores/story/story_store.dart';
import 'package:hacker_news_app/widgets/card_wrapper.dart';
import 'package:hacker_news_app/widgets/comment_list_item.dart';

class CommentList extends StatelessWidget {
  final StoryStore store;

  const CommentList({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: store.commentIds.length,
      itemBuilder: (context, index) => CardWrapper(
        child: _makeCommentCard(context, store.commentIds[index]),
      ),
    );
  }

  _makeCommentCard(BuildContext context, int commentId) {
    // look up in cache
    if (store.commentCache.containsKey(commentId)) {
      return CommentListItem(comment: store.commentCache[commentId]!);
    }

    return FutureBuilder(
      future: store.getComment(commentId),
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

        return CommentListItem(comment: snapshot.data!);
      },
    );
  }
}

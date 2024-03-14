import 'package:flutter/material.dart';
import 'package:hacker_news_app/stores/feed/feed_store.dart';
import 'package:hacker_news_app/widgets/feed_list.dart';
import 'package:provider/provider.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<FeedStore>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('HackerNews'),
      ),
      body: FutureBuilder(
        future: store.refreshFeed(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error!.toString()),
              );
            }

            return const FeedList();
          }
        },
      ),
    );
  }
}

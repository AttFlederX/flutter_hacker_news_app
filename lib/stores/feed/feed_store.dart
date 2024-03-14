import 'package:hacker_news_app/models/story/story.dart';
import 'package:hacker_news_app/services/api_service.dart';
import 'package:mobx/mobx.dart';
part 'feed_store.g.dart';

// ignore: library_private_types_in_public_api
class FeedStore = _FeedStoreBase with _$FeedStore;

abstract class _FeedStoreBase with Store {
  final _apiService = ApiService();

  @observable
  List<int> storyIds = [];

  @observable
  Map<int, Story> storyCache = {};

  @action
  Future refreshFeed() async {
    storyIds = await _apiService.getFeedStoryIds();
    storyCache = {};
  }

  @action
  Future<Story> getStory(int id) async {
    final story = await _apiService.getStory(id);
    storyCache[id] = story;

    return story;
  }
}

import 'package:hacker_news_app/models/comment/comment.dart';
import 'package:hacker_news_app/services/api_service.dart';
import 'package:mobx/mobx.dart';

part 'story_store.g.dart';

// ignore: library_private_types_in_public_api
class StoryStore = _StoryStoreBase with _$StoryStore;

abstract class _StoryStoreBase with Store {
  final _apiService = ApiService();

  @observable
  List<int> commentIds = [];

  @observable
  Map<int, Comment> commentCache = {};

  @action
  void setCommentIds(List<int> ids) {
    commentIds = ids;
  }

  @action
  Future<Comment> getComment(int id) async {
    final comment = await _apiService.getComment(id);
    commentCache[id] = comment;

    return comment;
  }
}

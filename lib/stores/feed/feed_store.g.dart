// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FeedStore on _FeedStoreBase, Store {
  late final _$storyIdsAtom =
      Atom(name: '_FeedStoreBase.storyIds', context: context);

  @override
  List<int> get storyIds {
    _$storyIdsAtom.reportRead();
    return super.storyIds;
  }

  @override
  set storyIds(List<int> value) {
    _$storyIdsAtom.reportWrite(value, super.storyIds, () {
      super.storyIds = value;
    });
  }

  late final _$storyCacheAtom =
      Atom(name: '_FeedStoreBase.storyCache', context: context);

  @override
  Map<int, Story> get storyCache {
    _$storyCacheAtom.reportRead();
    return super.storyCache;
  }

  @override
  set storyCache(Map<int, Story> value) {
    _$storyCacheAtom.reportWrite(value, super.storyCache, () {
      super.storyCache = value;
    });
  }

  late final _$refreshFeedAsyncAction =
      AsyncAction('_FeedStoreBase.refreshFeed', context: context);

  @override
  Future<dynamic> refreshFeed() {
    return _$refreshFeedAsyncAction.run(() => super.refreshFeed());
  }

  late final _$getStoryAsyncAction =
      AsyncAction('_FeedStoreBase.getStory', context: context);

  @override
  Future<Story> getStory(int id) {
    return _$getStoryAsyncAction.run(() => super.getStory(id));
  }

  @override
  String toString() {
    return '''
storyIds: ${storyIds},
storyCache: ${storyCache}
    ''';
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StoryStore on _StoryStoreBase, Store {
  late final _$commentIdsAtom =
      Atom(name: '_StoryStoreBase.commentIds', context: context);

  @override
  List<int> get commentIds {
    _$commentIdsAtom.reportRead();
    return super.commentIds;
  }

  @override
  set commentIds(List<int> value) {
    _$commentIdsAtom.reportWrite(value, super.commentIds, () {
      super.commentIds = value;
    });
  }

  late final _$commentCacheAtom =
      Atom(name: '_StoryStoreBase.commentCache', context: context);

  @override
  Map<int, Comment> get commentCache {
    _$commentCacheAtom.reportRead();
    return super.commentCache;
  }

  @override
  set commentCache(Map<int, Comment> value) {
    _$commentCacheAtom.reportWrite(value, super.commentCache, () {
      super.commentCache = value;
    });
  }

  late final _$getCommentAsyncAction =
      AsyncAction('_StoryStoreBase.getComment', context: context);

  @override
  Future<Comment> getComment(int id) {
    return _$getCommentAsyncAction.run(() => super.getComment(id));
  }

  late final _$_StoryStoreBaseActionController =
      ActionController(name: '_StoryStoreBase', context: context);

  @override
  void setCommentIds(List<int> ids) {
    final _$actionInfo = _$_StoryStoreBaseActionController.startAction(
        name: '_StoryStoreBase.setCommentIds');
    try {
      return super.setCommentIds(ids);
    } finally {
      _$_StoryStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
commentIds: ${commentIds},
commentCache: ${commentCache}
    ''';
  }
}

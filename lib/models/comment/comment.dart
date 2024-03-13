import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
class Comment with _$Comment {
  const Comment._();

  const factory Comment({
    required int id,
    required String by,
    required int time,
    required String text,
    required List<int>? kids,
  }) = _Comment;

  DateTime get dtm =>
      DateTime.fromMillisecondsSinceEpoch(time * 1000).toLocal();

  factory Comment.fromJson(Map<String, Object?> json) =>
      _$CommentFromJson(json);
}

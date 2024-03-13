import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'story.freezed.dart';
part 'story.g.dart';

@freezed
class Story with _$Story {
  const Story._();

  const factory Story({
    required int id,
    required String by,
    required int descendants,
    required int? score,
    required int time,
    required String title,
    required String url,
    required List<int>? kids,
  }) = _Story;

  DateTime get dtm =>
      DateTime.fromMillisecondsSinceEpoch(time * 1000).toLocal();

  factory Story.fromJson(Map<String, Object?> json) => _$StoryFromJson(json);
}

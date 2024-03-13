// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoryImpl _$$StoryImplFromJson(Map<String, dynamic> json) => _$StoryImpl(
      id: json['id'] as int,
      by: json['by'] as String,
      descendants: json['descendants'] as int,
      score: json['score'] as int?,
      time: json['time'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      kids: (json['kids'] as List<dynamic>?)?.map((e) => e as int).toList(),
    );

Map<String, dynamic> _$$StoryImplToJson(_$StoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'by': instance.by,
      'descendants': instance.descendants,
      'score': instance.score,
      'time': instance.time,
      'title': instance.title,
      'url': instance.url,
      'kids': instance.kids,
    };

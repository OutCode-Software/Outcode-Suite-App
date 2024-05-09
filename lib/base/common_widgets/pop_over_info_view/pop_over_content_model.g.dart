// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pop_over_content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PopOverContentModel _$PopOverContentModelFromJson(Map<String, dynamic> json) =>
    PopOverContentModel(
      json['avatar_url'] as String?,
      json['title'] as String?,
      json['text'] as String,
      json['video_url'] as String?,
      json['thumbnail_url'] as String?,
      json['button_text'] as String?,
      json['button_action'] as String,
    );

Map<String, dynamic> _$PopOverContentModelToJson(
        PopOverContentModel instance) =>
    <String, dynamic>{
      'avatar_url': instance.avatarUrl,
      'title': instance.title,
      'text': instance.message,
      'video_url': instance.videoUrl,
      'thumbnail_url': instance.thumbnailUrl,
      'button_text': instance.buttonText,
      'button_action': instance.buttonAction,
    };

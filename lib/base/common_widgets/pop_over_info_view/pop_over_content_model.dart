import 'package:freezed_annotation/freezed_annotation.dart';

part 'pop_over_content_model.g.dart';

@JsonSerializable()
class PopOverContentModel {
  PopOverContentModel(
    this.avatarUrl,
    this.title,
    this.message,
    this.videoUrl,
    this.thumbnailUrl,
    this.buttonText,
    this.buttonAction,
  );

  factory PopOverContentModel.fromJson(Map<String, dynamic> json) =>
      _$PopOverContentModelFromJson(json);
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  final String? title;
  @JsonKey(name: 'text')
  final String message;
  @JsonKey(name: 'video_url')
  final String? videoUrl;
  @JsonKey(name: 'thumbnail_url')
  final String? thumbnailUrl;
  @JsonKey(name: 'button_text')
  final String? buttonText;
  @JsonKey(name: 'button_action')
  final String buttonAction;
  Map<String, dynamic> toJson() => _$PopOverContentModelToJson(this);
}

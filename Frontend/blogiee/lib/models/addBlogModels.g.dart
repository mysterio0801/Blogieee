// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addBlogModels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddBlogModel _$AddBlogModelFromJson(Map<String, dynamic> json) {
  return AddBlogModel(
    id: json['id'] as String,
    coverImage: json['coverImage'] as String,
    body: json['body'] as String,
    comment: json['comment'] as int,
    like: json['like'] as int,
    share: json['share'] as int,
    title: json['title'] as String,
    username: json['username'] as String,
  );
}

Map<String, dynamic> _$AddBlogModelToJson(AddBlogModel instance) =>
    <String, dynamic>{
      'coverImage': instance.coverImage,
      'like': instance.like,
      'comment': instance.comment,
      'share': instance.share,
      'id': instance.id,
      'username': instance.username,
      'title': instance.title,
      'body': instance.body,
    };

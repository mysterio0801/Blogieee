import 'package:json_annotation/json_annotation.dart';

part 'addBlogModels.g.dart';

@JsonSerializable()
class AddBlogModel {
  String coverImage;
  int like;
  int comment;
  int share;
  @JsonKey(name : "_id")
  String id;
  String username;
  String title;
  String body;

  AddBlogModel({this.id, this.coverImage, this.body, this.comment, this.like, this.share, this.title, this.username});
  factory AddBlogModel.fromJson(Map<String, dynamic> json) => _$AddBlogModelFromJson(json);
  Map<String, dynamic> toJson() => _$AddBlogModelToJson(this);
  
}
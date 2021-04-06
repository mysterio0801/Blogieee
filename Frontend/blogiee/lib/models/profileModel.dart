import 'package:json_annotation/json_annotation.dart';

part 'profileModel.g.dart';

@JsonSerializable()
class ProfileModel {
  String name;
  String username;
  String about;
  String profession;
  String DOB;
  String titleline;
  ProfileModel({this.name, this.username, this.about, this.DOB, this.profession, this.titleline});
  factory ProfileModel.fromJson(Map<String, dynamic> json) => _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
  
}
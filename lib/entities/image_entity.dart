import 'package:json_annotation/json_annotation.dart';

part 'image_entity.g.dart';

@JsonSerializable()
class ImageEntity {
  String url;
  String title;
  String description;

  ImageEntity({required this.url, required this.title, required this.description});

  factory ImageEntity.fromJson(Map<String, dynamic> json) => _$ImageEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ImageEntityToJson(this);
}
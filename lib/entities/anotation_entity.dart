import 'package:json_annotation/json_annotation.dart';
import 'package:mybooknote/entities/image_entity.dart';

part 'anotation_entity.g.dart';

@JsonSerializable()
class AnotationEntity {
  String title;
  String description;
  List<ImageEntity> images;

  AnotationEntity({required this.title, required this.description, required this.images});

  factory AnotationEntity.fromJson(Map<String, dynamic> json) => _$AnotationEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AnotationEntityToJson(this);
}
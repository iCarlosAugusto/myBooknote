import 'package:mybooknote/entities/image_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subject_entity.g.dart';

@JsonSerializable()
class SubjectEntity {
  String id;
  String name;
  String professor;
  List<ImageEntity> images;

  SubjectEntity({required this.id, required this.name, required this.professor, required this.images});

  factory SubjectEntity.fromJson(Map<String, dynamic> json) => _$SubjectEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectEntityToJson(this);
}
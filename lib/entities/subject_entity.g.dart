// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubjectEntity _$SubjectEntityFromJson(Map<String, dynamic> json) =>
    SubjectEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      professor: json['professor'] as String,
      images: (json['images'] as List<dynamic>)
          .map((e) => ImageEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubjectEntityToJson(SubjectEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'professor': instance.professor,
      'images': instance.images,
    };

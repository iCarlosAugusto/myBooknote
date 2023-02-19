// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anotation_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnotationEntity _$AnotationEntityFromJson(Map<String, dynamic> json) =>
    AnotationEntity(
      title: json['title'] as String,
      description: json['description'] as String,
      images: (json['images'] as List<dynamic>)
          .map((e) => ImageEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AnotationEntityToJson(AnotationEntity instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'images': instance.images,
    };

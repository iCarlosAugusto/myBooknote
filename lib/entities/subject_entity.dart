import 'package:cloud_firestore/cloud_firestore.dart';

class SubjectEntity {
  SubjectEntity({required this.id, required this.name, required this.professor, required this.images});

  String id;
  String name;
  String professor;
  List<dynamic> images;

  factory SubjectEntity.fromJson(Map<String, dynamic> json) => SubjectEntity(
    id: json["id"],
    name: json["name"],
    professor: json["professor"],
    images: json["images"],
  );

  factory SubjectEntity.fromMap(DocumentSnapshot document) => SubjectEntity(
    id: document["id"],
    name: document["name"],
    professor: document["professor"],
    images: document["images"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "professor": professor,
    "images": images,
  };
}

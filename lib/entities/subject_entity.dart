class SubjectEntity {
  SubjectEntity({required this.id, required this.name, required this.professor, required this.images});

  String id;
  String name;
  String professor;
  String images;

  factory SubjectEntity.fromJson(Map<String, dynamic> json) => SubjectEntity(
    id: json["id"],
    name: json["name"],
    professor: json["professor"],
    images: json["images"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "professor": professor,
    "images": images,
  };
}

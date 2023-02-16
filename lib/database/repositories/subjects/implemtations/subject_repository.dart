import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mybooknote/database/repositories/subjects/i_subject_repository.dart';
import 'package:mybooknote/entities/subject_entity.dart';
import 'package:uuid/uuid.dart';

class SubjectRepository implements ISubjectRepository {

  @override
  Future<void> create({required String name, required String professor}) async {
    SubjectEntity subject = SubjectEntity(id: const Uuid().v4(), name: name, professor: professor, images: []);
    FirebaseFirestore dbFirebase = FirebaseFirestore.instance;
    await dbFirebase.collection('subjects').add(subject.toJson());
  }

  @override
  CollectionReference<Map<String, dynamic>> list()  {
    CollectionReference<Map<String, dynamic>> subjects = FirebaseFirestore.instance.collection('subjects');
    return subjects;
  }

  @override
  Future<void> delete({required int id}) async {
    
  }

  @override
  Future<void> addImage({required String id, required String urlImage}) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentSnapshot collectionData = await db.collection("subjects")
      .doc(id)
      .get();
    SubjectEntity subject = SubjectEntity.fromMap(collectionData);
    List<String> images = [urlImage, ...subject.images];
    await db.collection("subjects").doc(id).update({
      'images': images
    });
  }

  @override
  Future<List> listImages({required String id}) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentSnapshot collectionData = await db.collection("subjects").doc(id).get();
    //SubjectEntity subject = SubjectEntity.fromMap(collectionData);
    return collectionData['images'];
  }
}

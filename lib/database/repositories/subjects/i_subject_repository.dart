import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mybooknote/entities/image_entity.dart';

abstract class ISubjectRepository {
  Future<void> create({required String name, required String professor}) ;
  CollectionReference<Map<String, dynamic>>list();
  Future<void> delete({required int id});
  Future<ImageEntity> addImage({required String id, required String urlImage});
  Future<List<ImageEntity>> listImages({required String id});
}
import 'package:mybooknote/entities/subject_entity.dart';

abstract class ISubjectRepository {

  Future<void> create({required String name, required String professor}) ;
  Future<List<SubjectEntity>> list();
  Future<void> delete({required int id});
  Future<void> addImage({required int id, required String urlImage});
  Future<List<String>> listImages();
}
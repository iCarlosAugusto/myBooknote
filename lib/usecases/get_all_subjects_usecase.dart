import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mybooknote/database/repositories/subjects/i_subject_repository.dart';
import 'package:mybooknote/entities/subject_entity.dart';

class GetAllSubjectsUsecase {

  final ISubjectRepository _subjectRepository;
  GetAllSubjectsUsecase(this._subjectRepository);

  CollectionReference<Map<String, dynamic>> call()  {
    CollectionReference<Map<String, dynamic>> subjects = _subjectRepository.list();
    return subjects;
  }
}
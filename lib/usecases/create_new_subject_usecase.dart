import 'package:mybooknote/database/repositories/subjects/i_subject_repository.dart';
import 'package:mybooknote/entities/subject_entity.dart';

class CreateNewSubjectUseCase {

  final ISubjectRepository _subjectRepository;
  CreateNewSubjectUseCase(this._subjectRepository);

  call({required String name, required String professor }) async {
    SubjectEntity subject = await _subjectRepository.create(name: name, professor: professor);
    return subject;
  }
}